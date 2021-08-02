//
module lutburn (
    input   logic              clk,
    input   logic [31:0]       din,
    output  logic [31:0]       dout
);

    logic [31:0] addval=0, subval=0, sum;

    always_ff @(posedge clk) begin
        subval <= addval;
        addval <= addval + 1;
        sum  <= $signed(din) + $signed(addval);
        dout <= $signed(sum) - $signed(subval);
    end

endmodule

