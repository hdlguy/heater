// This is a block of logic that is designed to to just burn power.  It uses 
// DSP48, SRL, BRAM and CLB logic in a balanced way.  Pipelining has been
// used so that the clock speed can run close to the peak operating frequency of the FPGA.
// Parameters have been provided so that the mix of logic can be tuned for a particular part.
// Multiple channels can be instantiated and then enabled individually in order to scale power consumption.
// An LFSR is used as the data source so the toggle rate is exactly 50%. Knowing
// the toggle rate allows Xpower to predict current draw very accurately.
// A checker is at the end of the pipe to verify that the logic is running error free.
// Use with caution. Such a design can easily exceed current and thermal limitations 
// of a board.
module heater #(
    parameter Nsrl  = 6,
    parameter Nbram = 4,
    parameter Ndsp  = 6,
    parameter Npipe = 64
)(
    input   logic               clk,
    input   logic               enable,
    input   logic               err_clear,
    output  logic               error
);
    
    logic reset;
    always_ff @(posedge clk) reset <= ~enable;
    
    // an lfsr data source
    logic [31:0] lfsr_dout;    
    lfsr_generator lfsr_gen_inst(.clk(clk), .reset(reset), .dv_in(1'b1), .dv_out(), .dataout(lfsr_dout));

    // some srl delays
    //localparam Nsrl = 6;
    logic [Nsrl-1:0][31:0] srl_dout;
    srl32 srl32_0(.CLK(clk), .D(lfsr_dout), .Q(srl_dout[0]));
    genvar i,j;  
    generate for (i=1;i<Nsrl;i++) begin: gen_srl
        srl32 srl32_1(.CLK(clk), .D(srl_dout[i-1]), .Q(srl_dout[i]));
    end endgenerate

    // some BRAM delays
    //localparam Nbram = 4;
    logic [Nbram-1:0][31:0] bram_dout;
    (* dont_touch="true" *)logic [Nbram-1:0][9:0] count = 0;
    generate for (i=0;i<Nbram;i++) begin: gen_count
        always_ff @(posedge clk) count[i]++;
    end endgenerate
    sp_bram sp_bram_0(.clka(clk), .wea(1), .addra(count[0]), .dina(srl_dout[Nsrl-1]),  .douta(bram_dout[0]));
    generate for (i=1;i<Nbram;i++) begin: gen_bram
        sp_bram sp_bram_1(.clka(clk), .wea(1), .addra(count[i]), .dina(bram_dout[i-1]), .douta(bram_dout[i]));
    end endgenerate

    // some DSP48 delays
    //localparam Ndsp = 6;
    logic [Ndsp-1:0][47:0] dsp_dout, dsp_dout_q;
    dsp_nop dsp_0(.CLK(clk), .D(0), .C({16'd0, bram_dout[Nbram-1]}), .P(dsp_dout[0]));
    always_ff @(posedge clk) dsp_dout_q[0] <= dsp_dout[0];
    generate for (i=1;i<Ndsp;i++) begin: gen_dsp
        dsp_nop dsp_1(.CLK(clk), .D(0), .C(dsp_dout_q[i-1]), .P(dsp_dout[i]));
        always_ff @(posedge clk) dsp_dout_q[i] <= dsp_dout[i];
    end endgenerate

    // some pipeline registers
    //localparam Npipe = 64;
    logic [Npipe-1:0][31:0] ff_dout, lut_dout;
    always_ff @(posedge clk) ff_dout[0] <= dsp_dout_q[Ndsp-1][31:0];
    generate  for (i=1; i<Npipe; i++) begin: gen_reg  
        for (j=0; j<32; j++) begin: gen_ff
            (* dont_touch="true" *) LUT1 #(.INIT(2'b10)) LUT1_inst (.O(lut_dout[i-1][j]), .I0(ff_dout[i-1][j]));
            (* dont_touch="true" *) FDRE FDRE_inst(.Q(ff_dout[i][j]), .C(clk), .CE(1), .R(0), .D(lut_dout[i-1][j]));
        end  
    end  endgenerate 
    
    
    // an lsfr data checker
    logic err_clear_q,err_clear_qq;
    always_ff @(posedge clk) begin 
        err_clear_q <= err_clear; 
        err_clear_qq <= err_clear_q; 
    end
    lfsr_checker lfsr_check_inst(.clk(clk), .reset(err_clear_qq), .datain(ff_dout[Npipe-1]), .error(error));

endmodule


