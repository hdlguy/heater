# Script to compile the FPGA with zynq processor system all the way to bit file.

close_project -quiet

open_project proj.xpr
update_compile_order -fileset sources_1
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -jobs 4
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

open_run impl_1
write_checkpoint -force ./results/post_route.dcp
write_bitstream  -force ./results/top.bit
report_timing_summary -file ./results/post_route_timing_summary.rpt
report_utilization -file ./results/post_route_utilization.rpt
close_project





# close_project -quiet
# set outputDir ./results
# file mkdir $outputDir
# open_project proj.xpr

# synth_ip [get_ips *]

# synth_design -top artix_top
# write_checkpoint -force $outputDir/post_synth.dcp

# ## add ila logic analyzer.
# #source add_ila.tcl
# write_debug_probes -force ./results/ila0.ltx

# source ../../source/artix_top_late.xdc

# opt_design

# place_design

# phys_opt_design

# route_design
# write_checkpoint -force $outputDir/post_route.dcp
# report_route_status -file $outputDir/post_route_status.rpt
# report_timing_summary -file $outputDir/post_route_timing_summary.rpt
# report_power -file $outputDir/post_route_power.rpt
# report_utilization -file $outputDir/post_route_util.rpt
# report_drc -file $outputDir/post_imp_drc.rpt
# report_io -file $outputDir/post_imp_io.rpt
# #xilinx::ultrafast::report_io_reg -verbose -file $outputDir/io_regs.rpt

# set_property CFGBVS VCCO [current_design]
# set_property CONFIG_VOLTAGE 2.5 [current_design]

# set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
# set_property BITSTREAM.Config.SPI_BUSWIDTH 4 [current_design]
# write_bitstream -verbose -force $outputDir/artix_top.bit

# close_project

# write_cfgmem -force -format MCS -size 256 -interface SPIx4 -loadbit "up 0x0 ./results/artix_top.bit" -verbose ./results/artix_top.mcs




