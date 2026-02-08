# heater
An FPGA "heater" design that uses LFSR data to toggle logic for the purpose of dissipating power.

_**https://github.com/hdlguy/heater.git**_
## purpose
There are many reasons for wanting a design that does nothing other than toggle nodes to burn power.
1. You can test the current limits of your power distribution network.
1. You can test the cooling capability of your board.
1. You can verify the results of FPGA power estimation tools. This type of design has the advantage that you know the toggle rate of all the data. Power tools need that number to estimate power but it is difficult to guess. This artificial design produces data with an LFSR so the toggle rate is always 50%.
1. You can have a little fun.

## design
This design is written in Systemverilog and compiled with Xilinx Vivado tools.  It provides a parameterized number of channels of power burning pipelines. Also, each channel is parameterized with respect to the number of LUT, DSP48 and BRAM that are used.

Artix_top.v is the top level source for the Artix-50 version of the design. arty_top.v is the top level source for the Digilent Arty A7 version of the design. 

A VIO is used to control the number of channels that are enabled so that power consumption can be controlled at run-time. The VIO is also used to reset the error checker.

Build instructions are in the implement folder.
## results
This design was tested on a MicroZed 7020 board and an Avnet Artix 50t board.  I was able to achieve very high temperatures on the MicroZed. The MicroZed is my most useful board so I did not want to damage it. That's why I switched to the Artix board. Eventually, a die temperature greater than 100C was achieved and the current limit of the Artix board point of load regulator was exceeded causing the board to reboot.

Use with caution. :smiling_imp:

