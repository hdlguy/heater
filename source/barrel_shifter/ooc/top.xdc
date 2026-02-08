create_clock -period 2.5 -name clk [get_ports clk]

set_input_delay  -clock [get_clocks clk] 0.0 [get_ports [list din[*] shift[*] ]]
#set_output_delay -clock [get_clocks clk] 0.0 [get_ports {dout[*]}]