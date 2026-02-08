/// This is the base address of the AXI I/O 
#define     BASE_ADDRESS    0x80000000

/// This is the size of the memory hole we need to talk to the FPGA.
#define     PROTO_SIZE      0x00100000

#define     GPIO0_DATA      0x00000000  // heater enables
#define     GPIO1_DATA      0x00001000  // error clears
#define     GPIO1_DATA2     0x00001008  // error indications

