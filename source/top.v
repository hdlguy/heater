// This module is designed to run on a MicroZed 7020 board.
// Thirty two heater channels are instantiated. Individual channels
// then must be enable from software on the Zynq ARM processor.
module top (
    inout logic  [14:0]DDR_addr,
    inout logic  [2:0]DDR_ba,
    inout logic  DDR_cas_n,
    inout logic  DDR_ck_n,
    inout logic  DDR_ck_p,
    inout logic  DDR_cke,
    inout logic  DDR_cs_n,
    inout logic  [3:0]DDR_dm,
    inout logic  [31:0]DDR_dq,
    inout logic  [3:0]DDR_dqs_n,
    inout logic  [3:0]DDR_dqs_p,
    inout logic  DDR_odt,
    inout logic  DDR_ras_n,
    inout logic  DDR_reset_n,
    inout logic  DDR_we_n,
    inout logic  FIXED_IO_ddr_vrn,
    inout logic  FIXED_IO_ddr_vrp,
    inout logic  [53:0]FIXED_IO_mio,
    inout logic  FIXED_IO_ps_clk,
    inout logic  FIXED_IO_ps_porb,
    inout logic  FIXED_IO_ps_srstb);

    localparam N        = 32;
    localparam Nsrl     = 6;
    localparam Nbram    = 4;
    localparam Ndsp     = 6;
    localparam Npipe    = 32;

    logic axiclk;
    clk_wiz_0 instance_name (.clk_out200(clk), .clk_in100(axiclk)); 

    logic [N-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i < N; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 
    
    // the Zynq is here just to provide axiclk.
    system system_i(
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .axiclk(axiclk),        
        .GPIO0_out_tri_o(heater_enable),
        .GPIO1_in_tri_i(heater_error),
        .GPIO1_out_tri_o(heater_err_clear)
    );
    
    //heater_ila heater_ila_inst (.clk(clk), .probe0({heater_enable, heater_error, heater_err_clear}) ); // 96

endmodule

