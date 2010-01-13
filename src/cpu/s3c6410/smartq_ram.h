/* These numbers are for the Qimonda HYB25DC512160 */

#define CFG_COLS             	(CFG_COL_13 <<  0)      /* for 512Mbit */

#define CFG_ROWS		(CFG_ROW_10 <<  3)      /* for 512Mbit */

#define BURST			(CFG_BL_8)

#define CFG_AUTOPOWER		(0x1  << 13)
#define CFG_PD_CYCLES		(32 <<  7)     /* clocks before PD */
#define CFG_BURST_LEN		(BURST << 15)      

// was: #define DMC1_MEM_CFG		0x00010012
#define DMC1_MEM_CFG		\
       (CFG_BURST_LEN|CFG_AUTOPOWER|CFG_PD_CYCLES|CFG_ROWS|CFG_COLS) 

#define CFG2_RD_DELAY		(CFG2_RD_DELAY_DDR)

#define CFG2_TYPE		(CFG2_TYPE_DDR)

#define CFG2_WIDTH		(CFG2_WIDTH_32)

#define CFG2_DQM_INIT		(0x1 << 2 )
#define CFG2_SYNC		(0x1 << 0 )

// was: #define DMC1_MEM_CFG2		0xB45
#define DMC1_MEM_CFG2		\
		(CFG2_RD_DELAY|CFG2_TYPE|CFG2_WIDTH|CFG2_DQM_INIT|CFG2_SYNC)

#define BA_ROW_COL		(0x1  << 16)
#define ADDR_MATCH		(0x50 <<  8)
#define ADDR_MASK               (0xf8 <<  0)

// #define DMC1_CHIP0_CFG		0x150F8
#define DMC1_CHIP0_CFG          (BA_ROW_COL|ADDR_MATCH|ADDR_MASK)
#define DMC_DDR_32_CFG		0x0 		/* 32bit, DDR */

/* Memory Parameters */
/* DDR Parameters */

/* FYI: For HCLK=133MHz, clk=7.5188nS */

/* These numbers are for the Qimonda HYB25DC512160 */

#define RAM_tREFRESH		7800			/* ns */
#define RAM_tRAS		42			/* ns */
#define RAM_tRC 		60			/* ns */
#define RAM_tRCD		18			/* ns */
#define RAM_tRFC		72			/* ns */
#define RAM_tRP 		18			/* ns */
#define RAM_tRRD		12			/* ns */
#define RAM_tWR 		15			/* ns */
#define RAM_tXSR		200			/* ns */

/* CAS latency in clks */
#define RAM_clk_tCAS		3			/* clk */

#define MODE_BL			(BURST << 0)
#define MODE_CAS		(RAM_clk_tCAS << 4)

#define DRAM_MODE		(CMD_MODE | MODE_BL | MODE_CAS)  /* ModeReg */


