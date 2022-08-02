#
create_clock -period 10.000 -name clk100 -waveform {0.000 5.000} [get_ports {clkin100}]

set_property IOSTANDARD LVCMOS25    [get_ports {clkin100}]; # Vadj is 2.5V
set_property PACKAGE_PIN F4         [get_ports {clkin100}]


