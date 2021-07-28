This folder holds the build scripts for the FPGA designs.  Several folders hold the build files for different targets.

    artix-50t - The Avnet Artix-50t board.
    arty-a35  - The Digilent Arty A7 a35 board.
    kria_kv260 - The Xilinx Kria KV260.
    picozed_7030 - The Avnet Picozed 7030 SOM on the Avnet PCIe Carrier.
    uzed - The Avnet Ultrazed 3-EG board on the Avnet IO Carrier card.
    zcu104 - The Xilinx ZCU104 Zynq Ultrascale Eval board.
    zed - The original Zedboard with Zynq 7020.

These FPGA designs have been built and tested with Vivado 2016.4.

Start a Xilinx TCL shell or use the TCL window of the Vivado GUI. Change directory to the implement folder then run ...

    vivado -mode batch -source setup.tcl

    vivado -mode batch -source compile.tcl

On the Artix board you can burn the flash with ..

    vivado -mode batch -source program_spi.tcl

The Zed build produces top.bit.bin that can be loaded from Zynq processor under linux like this ...

    sudo cat top.bit.bin > /dev/xdevcfg
