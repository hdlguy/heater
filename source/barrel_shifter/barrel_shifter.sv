//
module barrel_shifter #(
    parameter integer W = 32,
    parameter integer Wsh = $clog2(W)
)(
    input   logic               clk,
    input   logic [Wsh-1:0]     shift,
    input   logic [W-1:0]       din,
    output  logic [W-1:0]       dout
);

    always_ff @(posedge clk) begin
        dout = (din<<(W-shift)) | (din>>shift);
    end

endmodule

