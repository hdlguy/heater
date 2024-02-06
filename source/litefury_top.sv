
module top (
    input  logic       sysclk_p, sysclk_n
);

    localparam N     = 32; // number of heaters
    localparam Nsrl  = 6;
    localparam Nbram = 4;
    localparam Ndsp  = 6;
    localparam Npipe = 32;

    logic clk400, clk100;
    litefury_clock_wiz clock_wiz_inst(.clk100(clk100), .clk400(clk400), .locked(), .clk_in1_p(sysclk_p), .clk_in1_n(sysclk_n));

    logic [N-1:0] heater_error, heater_err_clear, heater_err_clear_q, heater_enable;

    generate  for (genvar i=0; i<N; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk400), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear_q[i]));
    end  endgenerate 
    
    logic[N-1:0] heater_error_q;
    always_ff @(posedge clk100) heater_error_q <= heater_error;  // pipeline
    always_ff @(posedge clk100) heater_err_clear_q <= heater_err_clear;  // pipeline

    artix_vio vio_inst( .clk(clk100), .probe_in0(heater_error_q), .probe_out0(heater_err_clear), .probe_out1(heater_enable) );

endmodule

