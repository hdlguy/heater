# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
#create_project -part xck26-sfvc784-2lv-c -force proj 
create_project -part xczu2cg-sfvc784-1-i -force proj 
set_property target_language verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator
tclapp::install ultrafast -quiet

file delete -force ./ip
file mkdir ./ip

read_ip ../../source/clk_wiz_uzed/clk_wiz_uzed.xci
read_ip ../../source/dsp_nop/dsp_nop.xci
read_ip ../../source/sp_bram/sp_bram.xci
read_ip ../../source/srl32/srl32.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

source ../../source/alinx_system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/alinx_system/alinx_system.bd]
set_property synth_checkpoint_mode None [get_files ./proj.srcs/sources_1/bd/alinx_system/alinx_system.bd]

read_verilog -sv ../../source/axi_regfile/axi_regfile_v1_0_S00_AXI.sv
read_verilog -sv ../../source/lfsr.v
read_verilog -sv ../../source/lfsr_generator.v
read_verilog -sv ../../source/lfsr_checker.v
read_verilog -sv ../../source/heater.v
read_verilog -sv ../../source/alinx_top.v

#read_xdc ../../source/top.xdc

close_project


