#
create_clock -period 5.000 -name sysclk [get_ports {sysclk_p}]

set_property IOSTANDARD LVDS_25     [get_ports sysclk_*]
set_property PACKAGE_PIN J19        [get_ports sysclk_p]
set_property PACKAGE_PIN H19        [get_ports sysclk_n]



