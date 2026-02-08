/// This is the base address of the AXI I/O 
#define		BASE_ADDRESS	0x41200000

/// This is the size of the memory hole we need to talk to the FPGA.
#define		PROTO_SIZE		0x00100000

#define		GPIO0_DATA	    0x00000000  // heater enables
#define		GPIO1_DATA     	0x00010000  // error clears
#define		GPIO1_DATA2    	0x00010008  // error indications

//#define		XADC_OFFSET    	0x00020000
//#define		XADC_TEMP	    (XADC_OFFSET+0x200)
//#define		XADC_VCCINT	    (XADC_OFFSET+0x204)
//#define		XADC_VCCAUX	    (XADC_OFFSET+0x208)
//#define		XADC_VCCBRAM	(XADC_OFFSET+0x218)

//#define		XADC_VCCPINT	(XADC_OFFSET+0x234)
//#define		XADC_VCCPAUX	(XADC_OFFSET+0x238)
//#define		XADC_VCCODDR	(XADC_OFFSET+0x23C)
