// This module is designed to be the top level module on an 
// Avnet Artix 50t eval board.  Heater channels are enabled and
// errors monitored using a VIO core.  We find that enabling all
// 16 channels exceeds the current limit of the board and causes 
// the fpga to reconfigure.
module artix_top (
    input  logic       clk_in,
    output logic [7:0] led);

    localparam N     = 12; // number of heaters
    localparam Nsrl  = 6;
    localparam Nbram = 4;
    localparam Ndsp  = 6;
    localparam Npipe = 32;

    logic clk400, clk100;
    arty_clock_wiz clock_wiz_inst(.clk100(clk100), .clk400(clk400), .locked(), .clk_in1(clk_in));

    logic [N-1:0] heater_error, heater_err_clear, heater_err_clear_q, heater_enable;

    genvar i;  
    generate  for (i=0; i<N; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk400), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear_q[i]));
    end  endgenerate 
    
    logic[N-1:0] heater_error_q;
    always_ff @(posedge clk100) heater_error_q <= heater_error;  // pipeline
    always_ff @(posedge clk100) heater_err_clear_q <= heater_err_clear;  // pipeline

    artix_vio vio_inst( .clk(clk100), .probe_in0(heater_error_q), .probe_out0(heater_err_clear), .probe_out1(heater_enable) );

    always_ff @(posedge clk400) led <= heater_error_q[7:0];
    
endmodule

