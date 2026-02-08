
create_clock -period 5.000 -name sysclk -waveform {0.000 2.500} [get_ports {sysclk_p}]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IBUFDS_sysclk/O]


#set_max_delay -to [get_ports {led[*]}]            21.112
#set_max_delay -to [get_ports {usb_uart_txd}]      21.112


#set_input_delay -clock [get_clocks {sysclk}] -min -add_delay 0 [get_ports {usb_uart_rxd}]
#set_input_delay -clock [get_clocks {sysclk}] -min -add_delay 0 [get_ports {resetn}]


set_property IOSTANDARD LVCMOS18    [get_ports {led[*]}]
set_property PACKAGE_PIN AC16       [get_ports led[1]]
set_property PACKAGE_PIN W21        [get_ports led[0]]

set_property IOSTANDARD LVDS        [get_ports {sysclk_*}]
set_property DIFF_TERM  TRUE        [get_ports {sysclk_*}]
set_property PACKAGE_PIN T24        [get_ports sysclk_p]
set_property PACKAGE_PIN U24        [get_ports sysclk_n]

#set_property IOSTANDARD LVCMOS18    [get_ports {resetn}]
#set_property PACKAGE_PIN N26        [get_ports resetn]

#set_property IOSTANDARD LVCMOS33    [get_ports {usb_uart_*}]
#set_property PACKAGE_PIN A13        [get_ports usb_uart_txd]
#set_property PACKAGE_PIN A12        [get_ports usb_uart_rxd]

