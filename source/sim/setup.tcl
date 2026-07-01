# This file sets up the simulation environment.
create_project -part xc7a35ticsg324-1L -force proj 
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

#read_ip [glob ../dsp_nop/dsp_nop.xci ]
#generate_target {simulation} [get_ips *]

read_ip ../artix_vio/artix_vio.xci
read_ip ../arty_clock_wiz/arty_clock_wiz.xci
read_ip ../dsp_nop/dsp_nop.xci
read_ip ../sp_bram/sp_bram.xci
read_ip ../srl32/srl32.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

read_verilog -sv ../lfsr.v
read_verilog -sv ../lfsr_generator.v
read_verilog -sv ../lfsr_checker.v
read_verilog -sv ../heater.v
read_verilog -sv ../arty_top.v
read_verilog -sv ../arty_top_tb.v

add_files -fileset sim_1 -norecurse ./arty_top_tb_behav.wcfg

close_project


