# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -part xczu3eg-sfva625-1-e -force proj 
#set_property board_part em.avnet.com:microzed_7020:part0:1.2 [current_project]
#set_property board_part em.avnet.com:microzed_7020:part0:1.1 [current_project]
#set_property board_part em.avnet.com:ultrazed_eg_iocc_production:part0:1.0 [current_project]
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

source ../../source/uzed_system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/uzed_system/uzed_system.bd]
set_property synth_checkpoint_mode None [get_files ./proj.srcs/sources_1/bd/uzed_system/uzed_system.bd]

read_verilog -sv [glob ../../source/lfsr.v]
read_verilog -sv [glob ../../source/lfsr_generator.v]
read_verilog -sv [glob ../../source/lfsr_checker.v]
read_verilog -sv [glob ../../source/heater.v]
read_verilog -sv [glob ../../source/uzed_top.v]

#read_xdc ../../source/top.xdc

close_project


