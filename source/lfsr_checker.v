module lfsr_checker(
    input   logic           clk,
    input   logic           reset,
    input   logic   [31:0]  datain,
    output  logic           error);
    
    logic[31:0] datain_q;
    always_ff @(posedge clk) datain_q <= datain;

    logic   [31:0]  next_lfsr, next_lfsr_q;

    lfsr #(.WIDTH(32)) lfsr_inst (.datain(datain_q), .dataout(next_lfsr));

    always_ff @(posedge clk) next_lfsr_q <= next_lfsr;
    logic compare;
    always_ff @(posedge clk) if (next_lfsr_q == datain_q) compare <= 1; else compare <= 0;
    always_ff @(posedge clk) if (reset == 1) error <= 0; else if (!compare) error <= 1;

endmodule

