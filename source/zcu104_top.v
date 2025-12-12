//
module top (
    input   logic       reset
);

    localparam N        = 32;
    localparam Nsrl     = 40;
    localparam Nbram    = 9;
    localparam Ndsp     = 40;
    localparam Npipe    = 100;

    logic axiclk, clk;
    clk_wiz_uzed clk_wiz_inst (.clk_out(clk), .clk_in100(axiclk)); 

    logic [N-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i < N; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 
    
    // the Zynq is here just to provide axiclk.
    uzed_system system_i(
        .axi_aclk            (axiclk),        
        .GPIO_0_out_tri_o    (heater_enable),
        .GPIO2_0_in_tri_i    (heater_error),
        .GPIO_1_out_tri_o    (heater_err_clear)
    );

    //vio_0 vio_inst (.clk(clk), .probe_in0(error), .probe_out0(err_clear) );

endmodule

