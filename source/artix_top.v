// This module is designed to be the top level module on an 
// Avnet Artix 50t eval board.  Heater channels are enabled and
// errors monitored using a VIO core.  We find that enabling all
// 16 channels exceeds the current limit of the board and causes 
// the fpga to reconfigure.
module artix_top (
    input  logic       clk_in,
    output logic [7:0] led
);

    localparam N = 16;

    logic clk300, clk100;
    artix_clock_wiz clock_wiz_inst(.clk100(clk100), .clk300(clk300), .locked(), .clk_in1(clk_in));

    logic [N-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i<N; i++) begin: gen_code_label  
        heater #(.Nsrl(6), .Nbram(4), .Ndsp(6), .Npipe(64)) heater_inst(.clk(clk300), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 

    artix_vio vio_inst( .clk(clk100), .probe_in0(heater_error), .probe_out0(heater_err_clear), .probe_out1(heater_enable) );

    always_ff @(posedge clk300) led <= heater_error[7:0];
    
endmodule

