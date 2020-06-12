//
module top (
    input   logic       reset
);

    localparam Nchan = 16;
    localparam Nsrl  = 10;
    localparam Nbram = 5;
    localparam Ndsp  = 10;
    localparam Npipe = 60;

    logic axiclk, clk;
    clk_wiz_uzed clk_wiz_inst (.clk_out(clk), .clk_in100(axiclk)); 

    logic [Nchan-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i < Nchan; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 
    
    // the ZynqMP.
    uzed_system system_i(
        .axi_aclk            (axiclk),        
        .GPIO_0_out_tri_o    (heater_enable),
        .GPIO2_0_in_tri_i    (heater_error),
        .GPIO_1_out_tri_o    (heater_err_clear)
    );

endmodule

