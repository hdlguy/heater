# This file sets up the simulation environment.
#create_project -part xc7vx690tffg1761-2 -force proj 
create_project -force proj 
#set_property board_part em.avnet.com:microzed_7020:part0:1.1 [current_project]
set_property part xc7a35ticsg324-1L [current_project]
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

read_ip [glob ../source/sp_bram/sp_bram.xci ]
read_ip [glob ../source/srl32/srl32.xci ]
read_ip [glob ../source/dsp_nop/dsp_nop.xci ]
generate_target {simulation} [get_ips *]

read_verilog -sv ../source/lfsr.v
read_verilog -sv ../source/lfsr_generator.v
read_verilog -sv ../source/lfsr_checker.v
read_verilog -sv ../source/heater.v
read_verilog -sv ../source/heater_tb.v

current_fileset -simset [ get_filesets simset ]

set_property -name {xsim.elaborate.debug_level} -value {all} -objects [current_fileset -simset]
set_property -name {xsim.simulate.runtime} -value {200ns} -objects [current_fileset -simset]

close_project


