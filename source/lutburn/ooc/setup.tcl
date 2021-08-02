# This file sets up the simulation environment.
create_project -part xc7a35ticsg324-1L -force proj 
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

#read_ip [glob ../dsp_nop/dsp_nop.xci ]
#generate_target {simulation} [get_ips *]

read_verilog -sv ../lutburn.sv

read_xdc ./top.xdc


close_project


