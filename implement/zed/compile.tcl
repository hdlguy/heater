# Script to compile the FPGA all the way to bit file.
close_project -quiet

open_project proj.xpr
update_compile_order -fileset sources_1

set Ncpu 8

if {[get_property NEEDS_REFRESH [get_runs synth_1]]} {
    reset_run synth_1
    launch_runs synth_1 -jobs 8
    wait_on_run synth_1
    open_run synth_1
    report_drc -file ./results/post_synth_drc.rpt
}

reset_run impl_1
launch_runs impl_1 -jobs 8
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

open_run impl_1
write_checkpoint     -force ./results/post_route.dcp
write_debug_probes   -force ./results/probes.ltx
write_hwdef -force    -file ./results/top.hdf
report_timing_summary -file ./results/timing.rpt
report_utilization    -file ./results/utilization.rpt

set_property BITSTREAM.GENERAL.COMPRESS TRUE [get_designs impl_1]
write_bitstream -force ./results/top.bit

close_project

exec bootgen -image bitstream.bif -arch zynq -process_bitstream bin -o ./results/top.bit.bin -w




