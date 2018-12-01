# constraints for the Avnet Artix 50t board
set_property PACKAGE_PIN E3 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -period 5.0 [get_ports clk_in]

set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property PACKAGE_PIN T10 [get_ports {led[7]}]
set_property PACKAGE_PIN  T9 [get_ports {led[6]}]
set_property PACKAGE_PIN  J5 [get_ports {led[5]}]
set_property PACKAGE_PIN  H5 [get_ports {led[4]}]
set_property PACKAGE_PIN  H6 [get_ports {led[3]}]
set_property PACKAGE_PIN  J2 [get_ports {led[2]}]
set_property PACKAGE_PIN  J4 [get_ports {led[1]}]
set_property PACKAGE_PIN  F6 [get_ports {led[0]}]
