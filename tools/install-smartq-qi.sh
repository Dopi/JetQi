#!/bin/sh
# This script is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can modify it and/or redistribute it and
# just DO WHAT THE FUCK YOU WANT TO.

set -e

usage()
{
cat <<END
Usage: $0 DEVICE BOOTLOADER

  DEVICE: The SD card device to install the SmartQ Qi bootloader,
          for example /dev/sdb. Be sure to pass the right device name.

  BOOTLOADER: Location of the compiled Qi bootloader file.

The SmartQ Qi bootloader is written to the end of the SD card.
When partitioning remember to reserve 2 MiB of free, unpartitioned
space at the end.
END
exit $1
}

test "$#" -gt 0 || usage 0

device="$1"
test -n "$device" || usage 1

bootloader1="$2"
test -n "$bootloader1" || usage 1

bootloader2="$bootloader1"
test -n "$bootloader2"

sdhc_offset=1024
bootloader1_sectors=16
bootloader2_sectors=1008 # $sdhc_offset - $bootloader1_sectors
padding=2

device_sectors=`cat /sys/block/"$(basename "$device")"/size`

echo "==== Writting bootloader to $device ===="

dd if=/dev/zero of="$device" bs=512 \
	seek=$(($device_sectors - $padding)) \
	count=$padding
dd if="$bootloader1" of="$device" bs=512 \
	seek=$(($device_sectors - $bootloader1_sectors - $padding)) \
	count=$bootloader1_sectors
dd if="$bootloader2" of="$device" bs=512 \
	seek=$(($device_sectors - $bootloader2_sectors - $bootloader1_sectors - $padding)) \
	count=$bootloader2_sectors

# First bootloader location on SHDC
dd if="$bootloader1" of="$device" bs=512 \
	seek=$(($device_sectors - $bootloader1_sectors - $sdhc_offset - $padding)) \
	count=$bootloader1_sectors
dd if="$bootloader2" of="$device" bs=512 \
	seek=$(($device_sectors - $sdhc_offset - $bootloader2_sectors - $bootloader1_sectors - $padding)) \
	count=$bootloader2_sectors

echo "==== Done! ===="
