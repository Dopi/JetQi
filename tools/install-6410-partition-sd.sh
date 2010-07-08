#!/bin/sh
# 6410 SD Boot formatter
# (C) 2008 Openmoko, Inc
# Author: Andy Green <andy@openmoko.com>

# LAYOUT (if partition parameter is not specified)
# Partition table, then
# VFAT takes up remaining space here
# then...
#
EXT3_ROOTFS_SECTORS=$(( 256 * 1024 * 2 ))
EXT3_BACKUP_FS_SECTORS=$(( 8 * 1024 * 2 ))
QI_ALLOCATION=$(( 256 * 2 ))
#
# lastly fixed stuff: 8KByte initial boot, sig, padding
#
# ----------------------

echo "s3c6410 bootable SD partitioning utility"
echo "(C) Openmoko, Inc  Andy Green <andy@openmoko.com>"
echo

# these are fixed in iROM
QI_INITIAL=$(( 8 * 2 ))
SIG=1


# display usage message and exit
# any arguments are displayed as an error message
USAGE()
{
  echo
  [ -z "$1" ] || echo ERROR: $*
  echo
  echo 'This formats a SD card for usage on SD Card boot'
  echo '  on 6410 based systems'
  echo
  echo Usage: $(basename "$0") '<device> <card> <bootloader> <partition>'
  echo '       device     = disk device name for SD Card, e.g. sde /dev/sdf'
  echo '       card       = sd | sdhc'
  echo '       bootloader = /path/to/qi-binary'
  echo '       partition  = vfat | NN | NN,NN | NN,NN,NN | NN,NN,NN,NN | no'
  echo '                  * vfat -> main-vfat[rest] + rootfs[256M] + backupfs[8M]'
  echo '                    NN   -> rootfs1[NN%] + .. + rootfs4[NN%]'
  echo '                    NN=0 -> will skip the partition'
  echo '                    no   -> leave partitions alone'
  echo
  echo 'Note:  * => default action if no parameter specified'
  echo '       sum(NN) must be in [1..100]'
  echo
  echo 'e.g. '$(basename "$0")' sdb sdhc images/qi 0,30,0,45'
  echo '     will format an SDHC with partition 2 receiving 20% and partition 4'
  echo '     receiving 45% of the disk capacity and the remaining 35% will be'
  echo '     unused.'
  echo '     Capacity is calculated after subtracting the space reserved for Qi.'
  echo '     Partitions 1 and 3 will not be used.'
  exit 1
}

[ -z "$1" -o -z "$2" -o -z "$3" ] && USAGE 'Missing arguments'

dev="$1"
card="$2"
qi="$3"
partition="$4"

case "${card}" in
  [sS][dD][hH][cC])
    PADDING=1025
    ;;
  [sS][dD])
    PADDING=1
    ;;
  *)
    USAGE "${card} is an unknown card type"
esac

# the amount of space that must remain unused at the end of the disk
REAR_SECTORS=$(( $QI_ALLOCATION + $QI_INITIAL + $SIG + $PADDING ))

# validate parameters
[ -b "${dev}" ] || dev="/dev/${dev}"
[ -b "${dev}" ] || USAGE "${dev} is not a valid block device"
[ X"${dev}" = X"${dev%%[0-9]}" ] || USAGE "${dev} is a partition, please use device: perhaps ${dev%%[0-9]}"

echo "Checking for mounted partitions..."
grep "${dev}" /proc/mounts && USAGE "partitions on ${dev} are mounted, please unmount them"
[ -e "${qi}" ] || USAGE "bootloader file: ${qi} does not exist"

# get size of device
bytes=$(echo p | fdisk "${dev}" 2>&1 | sed '/^Disk.*, \([0-9]*\) bytes/s//\1/p;d')
SECTORS=$(($bytes / 512))

[ -z "$SECTORS" ]  && USAGE "could not find size for ${dev}"
[ "$SECTORS" -le 0 ]  && USAGE "invalid size: '${SECTORS}' for ${dev}"

echo "${dev} is $SECTORS 512-byte blocks"


# Partition and format a disk (or SD card)
# Parameters to format function are:
#
#   device -> device to partition e.g. /dev/sdX
#
# Partition 1 parameters:
#
#   label  -> file system volume label e.g. rootfs
#   sizeMB -> size of the partition in MB e.g. 256
#   fstype -> filesystem type e.g. ext2, ext3, vfat (look at /sbin/mkfs.* for others)
#
# Notes: 1. Repeat "label, sizeMB, fstype" for partitions 2..4
#        2. Partitions 2..4 are optional
#        3. Do not repeat device parameter
#        4. To skip a partition use: 'null 0 none' for that partition

FORMAT()
{
  local device label sizeMB fstype p partition flag skip
  device="$1"; shift
  (
    p=0
    flag=0
    echo o
    while [ $# -gt 0 ]
    do
      label="$1"; shift
      sizeMB="$1"; shift
      fstype="$1"; shift
      p=$((${p} + 1))
      skip=NO
      [ ${sizeMB} -le 0 ] && skip=YES
      case "${label}" in
        [nN][uU][lL][lL])
          skip=YES
          ;;
        *)
          ;;
      esac
      case "${skip}" in
        [yY][eE][sS]|[yY])
          ;;
        *)
          echo n
          echo p
          echo ${p}
          echo
          echo +${sizeMB}M
          case "${fstype}" in
            [vV][fF][aA][tT]|[mM][sS][dD][oO][sS])
              echo t
              # fdisk is "helpful" & will auto select partition if there is only one
              # so do not output partition number if this is the first partition
              [ "${flag}" -eq 1 ] && echo ${p}
              echo 0b
              ;;
            *)
              ;;
          esac
          flag=1
          ;;
      esac
    done
    echo p
    echo w
    echo q
    ) | fdisk "${device}"
  p=0
  while [ $# -gt 0 ]
  do
    label="$1"; shift
    sizeMB="$1"; shift
    fstype="$1"; shift
    p=$((${p} + 1))
    partition="${dev}${p}"
    skip=NO
    [ ${sizeMB} -eq 0 ] && skip=YES
    case "${label}" in
      [nN][uU][lL][lL])
        skip=YES
        ;;  
    esac

    case "${skip}" in
      [yY][eE][sS]|[yY])
        echo "Skipping: ${partition}"
        ;;
      *)
        echo "Formatting: ${partition}  -> ${fstype}[${sizeMB}MB]"
        case "${fstype}" in
          [vV][fF][aA][tT]|[mM][sS][dD][oO][sS])
            mkfs.${fstype} -n "${label}" "${partition}"
            ;;
          *)
            mkfs.${fstype} -L "${label}" "${partition}"
            ;;
        esac
        ;;
    esac
  done
}

# format the disk
case "${partition}" in

  # this case also hadles the default case (i.e. empty string: "")
  [vV][fF][aA][tT]|"")
    EXT3_TOTAL_SECTORS=$(( $EXT3_ROOTFS_SECTORS + $EXT3_BACKUP_FS_SECTORS ))
    FAT_SECTORS=$(( $SECTORS - $EXT3_TOTAL_SECTORS - $REAR_SECTORS ))
    FAT_MB=$(( $FAT_SECTORS / 2048 ))
    EXT3_ROOTFS_MB=$(( ${EXT3_ROOTFS_SECTORS} / 2048 ))
    EXT3_BACKUP_FS_MB=$(( ${EXT3_BACKUP_FS_SECTORS} / 2048 ))

    echo Creating VFAT partition of ${FAT_MB} MB
    echo Creating Linux partition of ${EXT3_ROOTFS_MB} MB
    echo Creating backup Linux partition of ${EXT3_BACKUP_FS_MB} MB
    FORMAT "${dev}" \
      main-vfat "${FAT_MB}" vfat \
      rootfs "${EXT3_ROOTFS_MB}" ext3 \
      backupfs "${EXT3_BACKUP_FS_MB}" ext3
    ;;

  # decode partition or partition list
  *,*|100|[1-9][0-9]|[1-9])
    arg="${partition},"
    for v in 1 2 3 4
    do
      eval n${v}="\${arg%%,*}"
      eval n${v}="\${n${v}:-0}"
      arg="${arg#*,},"
    done
    total=$(( ${n1} + ${n2} + ${n3} + ${n4} ))
    echo Percentage of disk partitioned = ${total}%
    [ ${total} -gt 100 -o ${total} -lt 1 ] && USAGE partition: "'${partition}' => ${total}% outside [1..100]"

    EXT3_TOTAL_SECTORS=$(( $SECTORS - $REAR_SECTORS ))
    EXT3_ROOTFS1_SECTORS=$(( $EXT3_TOTAL_SECTORS * $n1 / 100 ))
    EXT3_ROOTFS2_SECTORS=$(( $EXT3_TOTAL_SECTORS * $n2 / 100 ))
    EXT3_ROOTFS3_SECTORS=$(( $EXT3_TOTAL_SECTORS * $n3 / 100 ))
    EXT3_ROOTFS4_SECTORS=$(( $EXT3_TOTAL_SECTORS * $n4 / 100 ))
    EXT3_ROOTFS1_MB=$(( ${EXT3_ROOTFS1_SECTORS} / 2048 ))
    EXT3_ROOTFS2_MB=$(( ${EXT3_ROOTFS2_SECTORS} / 2048 ))
    EXT3_ROOTFS3_MB=$(( ${EXT3_ROOTFS3_SECTORS} / 2048 ))
    EXT3_ROOTFS4_MB=$(( ${EXT3_ROOTFS4_SECTORS} / 2048 ))

    echo Creating Linux partition 1 of ${EXT3_ROOTFS1_MB} MB
    echo Creating Linux partition 2 of ${EXT3_ROOTFS2_MB} MB
    echo Creating Linux partition 3 of ${EXT3_ROOTFS3_MB} MB
    echo Creating Linux partition 4 of ${EXT3_ROOTFS4_MB} MB

    FORMAT "${dev}" \
      rootfs1 "${EXT3_ROOTFS1_MB}" ext3 \
      rootfs2 "${EXT3_ROOTFS2_MB}" ext3 \
      rootfs3 "${EXT3_ROOTFS3_MB}" ext3 \
      rootfs4 "${EXT3_ROOTFS4_MB}" ext3
    ;;

  [Nn]*)
    # do not format
    ;;

  *)
    USAGE "'${partition}' is an unknown partition config"
    ;;
esac


# copy the full bootloader image to the right place after the
# partitioned area
echo
echo Installing Qi bootloader from: ${qi}

dd if="${qi}" of="${dev}" bs=512 count=512 \
  seek=$(( $SECTORS - $REAR_SECTORS ))
dd if="${qi}" of="${dev}" bs=512 \
  seek=$(( $SECTORS - $REAR_SECTORS + $QI_ALLOCATION )) \
  count=$QI_INITIAL
dd if=/dev/zero of="${dev}" bs=512 \
  seek=$(( $SECTORS - $REAR_SECTORS + $QI_ALLOCATION + $QI_INITIAL )) \
  count=$(( $SIG + $PADDING ))

# done
echo
echo "**** completed"

