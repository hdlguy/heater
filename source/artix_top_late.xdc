#set_max_delay -datapath_only -from [get_clocks clk100_artix_clock_wiz] -through [get_nets heater_err_clear[*]] -to [get_clocks clk300_artix_clock_wiz] 5
#set_max_delay -datapath_only -from [get_clocks clk100_artix_clock_wiz] -through [get_nets heater_enable[*]] -to [get_clocks clk300_artix_clock_wiz] 5
#set_max_delay -datapath_only -from [get_clocks clk300_artix_clock_wiz] -through [get_nets heater_error[*]] -to [get_clocks clk100_artix_clock_wiz] 5

