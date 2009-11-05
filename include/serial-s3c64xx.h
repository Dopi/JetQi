/*
 * (C) Copyright 2007 OpenMoko, Inc.
 * Author: xiangfu liu <xiangfu@openmoko.org>
 *
 * Configuation settings for the FIC Neo GTA02 Linux GSM phone
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */


#ifndef __SERIAL_S3C64XX_H__
#define __SERIAL_S3C64XX_H__

#define UART0	    0
#define UART1	    1
#define UART2	    2

#define rGPHCON     (*(volatile unsigned *)0x56000070)	/*UART 0 Line control*/

#define rULCON0     (*(volatile unsigned *)0x50000000)	/*UART 0 Line control*/
#define rUCON0      (*(volatile unsigned *)0x50000004)	/*UART 0 Control*/
#define rUFCON0     (*(volatile unsigned *)0x50000008)	/*UART 0 FIFO control*/
#define rUMCON0     (*(volatile unsigned *)0x5000000c)	/*UART 0 Modem control*/
#define rUTRSTAT0   (*(volatile unsigned *)0x50000010)	/*UART 0 Tx/Rx status*/
#define rUERSTAT0   (*(volatile unsigned *)0x50000014)	/*UART 0 Rx error status*/
#define rUFSTAT0    (*(volatile unsigned *)0x50000018)	/*UART 0 FIFO status*/
#define rUMSTAT0    (*(volatile unsigned *)0x5000001c)	/*UART 0 Modem status*/
#define rUBRDIV0    (*(volatile unsigned *)0x50000028)	/*UART 0 Baud rate divisor*/

#define rULCON1     (*(volatile unsigned *)0x50004000)	/*UART 1 Line control*/
#define rUCON1      (*(volatile unsigned *)0x50004004)	/*UART 1 Control*/
#define rUFCON1     (*(volatile unsigned *)0x50004008)	/*UART 1 FIFO control*/
#define rUMCON1     (*(volatile unsigned *)0x5000400c)	/*UART 1 Modem control*/
#define rUTRSTAT1   (*(volatile unsigned *)0x50004010)	/*UART 1 Tx/Rx status*/
#define rUERSTAT1   (*(volatile unsigned *)0x50004014)	/*UART 1 Rx error status*/
#define rUFSTAT1    (*(volatile unsigned *)0x50004018)	/*UART 1 FIFO status*/
#define rUMSTAT1    (*(volatile unsigned *)0x5000401c)	/*UART 1 Modem status*/
#define rUBRDIV1    (*(volatile unsigned *)0x50004028)	/*UART 1 Baud rate divisor*/

#define rULCON2     (*(volatile unsigned *)0x50008000)	/*UART 2 Line control*/
#define rUCON2      (*(volatile unsigned *)0x50008004)	/*UART 2 Control*/
#define rUFCON2     (*(volatile unsigned *)0x50008008)	/*UART 2 FIFO control*/
#define rUTRSTAT2   (*(volatile unsigned *)0x50008010)	/*UART 2 Tx/Rx status*/
#define rUERSTAT2   (*(volatile unsigned *)0x50008014)	/*UART 2 Rx error status*/
#define rUFSTAT2    (*(volatile unsigned *)0x50008018)	/*UART 2 FIFO status*/
#define rUBRDIV2    (*(volatile unsigned *)0x50008028)	/*UART 2 Baud rate divisor*/

#define WrUTXH0(ch) (*(volatile unsigned char *)0x50000020)=(unsigned char)(ch)
#define RdURXH0()   (*(volatile unsigned char *)0x50000024)
#define WrUTXH1(ch) (*(volatile unsigned char *)0x50004020)=(unsigned char)(ch)
#define RdURXH1()   (*(volatile unsigned char *)0x50004024)
#define WrUTXH2(ch) (*(volatile unsigned char *)0x50008020)=(unsigned char)(ch)
#define RdURXH2()   (*(volatile unsigned char *)0x50008024)

extern void serial_init_115200_s3c64xx(const int uart, const int pclk_MHz);
extern void serial_putc_s3c64xx(const int uart, const char c);
extern int puts(const char *string);

#endif
