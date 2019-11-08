// This module is designed to run on a MicroZed 7020 board.
// Thirty two heater channels are instantiated. Individual channels
// then must be enable from software on the Zynq ARM processor.
module top (
    input   logic       reset
);

    localparam N = 32;

    logic axiclk, clk;
    clk_wiz_uzed clk_wiz_inst (.clk_out200(clk), .clk_in100(axiclk)); 

    logic [N-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i < N; i++) begin: gen_code_label  
        heater #(.Nsrl(12), .Nbram(6), .Ndsp(11), .Npipe(80)) heater_inst(.clk(clk), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 
    
    // the Zynq is here just to provide axiclk.
    system system_i(
        .reset              (reset),
        .axiclk             (axiclk),        
        .GPIO0_out_tri_o    (heater_enable),
        .GPIO1_in_tri_i     (heater_error),
        .GPIO1_out_tri_o    (heater_err_clear)
    );

    //vio_0 vio_inst (.clk(clk), .probe_in0(error), .probe_out0(err_clear) );

endmodule

