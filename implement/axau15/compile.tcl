# Script to compile the FPGA all the way to bit file.
close_project -quiet
file delete -force results
file mkdir ./results

open_project proj.xpr
update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1 -jobs 8
wait_on_run synth_1

launch_runs impl_1 -jobs 8
wait_on_run impl_1

open_run impl_1
write_checkpoint     -force ./results/post_route.dcp
write_debug_probes   -force ./results/top.ltx
write_hw_platform -fixed -force -file   ./results/top.xsa
report_timing_summary -file ./results/timing.rpt
report_utilization    -file ./results/utilization.rpt

set_property BITSTREAM.GENERAL.COMPRESS TRUE [get_designs impl_1]
write_bitstream -verbose -force -bin_file ./results/top.bit

close_project


