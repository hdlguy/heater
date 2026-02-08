# constraints for the Avnet Artix 50t board
set_property PACKAGE_PIN N11 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -period 5.0 [get_ports clk_in]

set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]
set_property PACKAGE_PIN M1 [get_ports {led[7]}]
set_property PACKAGE_PIN N1 [get_ports {led[6]}]
set_property PACKAGE_PIN M2 [get_ports {led[5]}]
set_property PACKAGE_PIN N2 [get_ports {led[4]}]
set_property PACKAGE_PIN N3 [get_ports {led[3]}]
set_property PACKAGE_PIN M4 [get_ports {led[2]}]
set_property PACKAGE_PIN L4 [get_ports {led[1]}]
set_property PACKAGE_PIN L5 [get_ports {led[0]}]
