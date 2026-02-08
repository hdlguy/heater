//
module top (
    //output logic [3:0] led
);

    localparam Nchan = 32;
    localparam Nsrl  = 8;
    localparam Nbram = 4;
    localparam Ndsp  = 30;
    localparam Npipe = 32;

    logic clk;
    logic [Nchan-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i < Nchan; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst (.clk(clk), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 
    
    logic [31:0]    M00_AXI_araddr;
    logic [2:0]     M00_AXI_arprot;
    logic           M00_AXI_arready;
    logic           M00_AXI_arvalid;
    logic [31:0]    M00_AXI_awaddr;
    logic [2:0]     M00_AXI_awprot;
    logic           M00_AXI_awready;
    logic           M00_AXI_awvalid;
    logic           M00_AXI_bready;
    logic [1:0]     M00_AXI_bresp;
    logic           M00_AXI_bvalid;
    logic [31:0]    M00_AXI_rdata;
    logic           M00_AXI_rready;
    logic [1:0]     M00_AXI_rresp;
    logic           M00_AXI_rvalid;
    logic [31:0]    M00_AXI_wdata;
    logic           M00_AXI_wready;
    logic [3:0]     M00_AXI_wstrb;
    logic           M00_AXI_wvalid;

    logic           axi_aclk;
    logic [0:0]     axi_aresetn;
    
    clk_wiz_uzed clk_wiz_inst (.clk_out(clk), .clk_in100(axi_aclk)); 

    kria_system system_i (
        .M00_AXI_araddr     (M00_AXI_araddr),
        .M00_AXI_arprot     (M00_AXI_arprot),
        .M00_AXI_arready    (M00_AXI_arready),
        .M00_AXI_arvalid    (M00_AXI_arvalid),
        .M00_AXI_awaddr     (M00_AXI_awaddr),
        .M00_AXI_awprot     (M00_AXI_awprot),
        .M00_AXI_awready    (M00_AXI_awready),
        .M00_AXI_awvalid    (M00_AXI_awvalid),
        .M00_AXI_bready     (M00_AXI_bready),
        .M00_AXI_bresp      (M00_AXI_bresp),
        .M00_AXI_bvalid     (M00_AXI_bvalid),
        .M00_AXI_rdata      (M00_AXI_rdata),
        .M00_AXI_rready     (M00_AXI_rready),
        .M00_AXI_rresp      (M00_AXI_rresp),
        .M00_AXI_rvalid     (M00_AXI_rvalid),
        .M00_AXI_wdata      (M00_AXI_wdata),
        .M00_AXI_wready     (M00_AXI_wready),
        .M00_AXI_wstrb      (M00_AXI_wstrb),
        .M00_AXI_wvalid     (M00_AXI_wvalid),
        //
        .axi_aclk           (axi_aclk),
        .axi_aresetn        (axi_aresetn)
    );
    
    localparam int Nregs = 16;
    localparam int Nregaddr = $clog2(Nregs)+2; // number of address bits to register file (byte addressing)
    logic [Nregs-1:0][31:0] slv_reg, slv_read, slv_wr_pulse;

    assign slv_read[0] = 32'hdeadbeef;

    assign slv_read[1] = 32'h76543210;

    assign slv_read[2] = heater_error;

    assign heater_enable    = slv_reg[3];

    assign heater_err_clear = slv_reg[4];
    
    assign slv_read[Nregs-1:3] = slv_reg[Nregs-1:3];

	axi_regfile_v1_0_S00_AXI #	(
		.C_S_AXI_DATA_WIDTH(32),
		.C_S_AXI_ADDR_WIDTH(Nregaddr) 
	) axi_regfile_inst (
        // register interface
        .slv_read(slv_read), 
        .slv_reg (slv_reg),  
        .slv_wr_pulse   (),
        // axi interface
		.S_AXI_ACLK    (axi_aclk),
		.S_AXI_ARESETN (axi_aresetn),
        //
		.S_AXI_ARADDR  (M00_AXI_araddr[Nregaddr-1:0]),
		.S_AXI_ARPROT  (M00_AXI_arprot ),
		.S_AXI_ARREADY (M00_AXI_arready),
		.S_AXI_ARVALID (M00_AXI_arvalid),
		.S_AXI_AWADDR  (M00_AXI_awaddr[Nregaddr-1:0]),
		.S_AXI_AWPROT  (M00_AXI_awprot ),
		.S_AXI_AWREADY (M00_AXI_awready),
		.S_AXI_AWVALID (M00_AXI_awvalid),
		.S_AXI_BREADY  (M00_AXI_bready ),
		.S_AXI_BRESP   (M00_AXI_bresp  ),
		.S_AXI_BVALID  (M00_AXI_bvalid ),
		.S_AXI_RDATA   (M00_AXI_rdata  ),
		.S_AXI_RREADY  (M00_AXI_rready ),
		.S_AXI_RRESP   (M00_AXI_rresp  ),
		.S_AXI_RVALID  (M00_AXI_rvalid ),
		.S_AXI_WDATA   (M00_AXI_wdata  ),
		.S_AXI_WREADY  (M00_AXI_wready ),
		.S_AXI_WSTRB   (M00_AXI_wstrb  ),
		.S_AXI_WVALID  (M00_AXI_wvalid )
	);
	

endmodule
    
