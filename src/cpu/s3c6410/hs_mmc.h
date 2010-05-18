#ifndef __HS_MMC_H__
#define __HS_MMC_H__

/////////////////////////////////////////////////////////////////////////////////////////////////
//#define       SDHC_MONITOR             (*(volatile unsigned *)0x4800004c)
//#define       SDHC_SLOT_INT_STAT               (*(volatile unsigned *)0x480000fc)

/////////////////////////////////////////////////////////////////////////////////////////////////
#define	SD_HCLK		1
#define	SD_EPLL		2
#define	SD_EXTCLK	3

#define	NORMAL	0
#define	HIGH	1

//Normal Interrupt Signal Enable
#define	READWAIT_SIG_INT_EN		(1<<10)
#define	CARD_SIG_INT_EN			(1<<8)
#define	CARD_REMOVAL_SIG_INT_EN		(1<<7)
#define	CARD_INSERT_SIG_INT_EN		(1<<6)
#define	BUFFER_READREADY_SIG_INT_EN	(1<<5)
#define	BUFFER_WRITEREADY_SIG_INT_EN	(1<<4)
#define	DMA_SIG_INT_EN			(1<<3)
#define	BLOCKGAP_EVENT_SIG_INT_EN	(1<<2)
#define	TRANSFERCOMPLETE_SIG_INT_EN	(1<<1)
#define	COMMANDCOMPLETE_SIG_INT_EN	(1<<0)

//Normal Interrupt Status Enable
#define	READWAIT_STS_INT_EN		(1<<10)
#define	CARD_STS_INT_EN			(1<<8)
#define	CARD_REMOVAL_STS_INT_EN		(1<<7)
#define	CARD_INSERT_STS_INT_EN		(1<<6)
#define	BUFFER_READREADY_STS_INT_EN	(1<<5)
#define	BUFFER_WRITEREADY_STS_INT_EN	(1<<4)
#define	DMA_STS_INT_EN			(1<<3)
#define	BLOCKGAP_EVENT_STS_INT_EN	(1<<2)
#define	TRANSFERCOMPLETE_STS_INT_EN	(1<<1)
#define	COMMANDCOMPLETE_STS_INT_EN	(1<<0)

#endif /*__HS_MMC_H__*/
