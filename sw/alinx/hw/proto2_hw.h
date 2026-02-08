#define     BASE_ADDRESS    0x80000000
#define     PROTO_SIZE      0x00100000

#define     AXI_REG_OFFSET  0x00000000

// these are indexes into the register file. access with something like regptr[FPGA_ID]
#define     FPGA_ID             0  // Currently returns 0xDEADBEEF
#define     FPGA_VERSION        1  // Returns major and minor version numbers.
#define     HEATER_ERROR        2  
#define     HEATER_ENABLE       3  
#define     HEATER_CLEAR        4  
