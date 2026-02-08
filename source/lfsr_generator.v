module lfsr_generator(
    input   logic           clk,
    input   logic           reset,
    input   logic           dv_in,
    output  logic           dv_out,
    output  logic   [31:0]  dataout);

    logic   [31:0]  next_lfsr;

    lfsr #(.WIDTH(32)) lfsr_inst (.datain(dataout), .dataout(next_lfsr));

    always_ff @(posedge clk) begin
        if (reset==1) begin
            dataout <= 1;
            dv_out  <= 0;
        end else begin
            dv_out <= dv_in;
            if (dv_in==1) dataout <= next_lfsr;
        end
    end

endmodule
