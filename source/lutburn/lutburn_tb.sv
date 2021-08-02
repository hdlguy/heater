`timescale 1ns / 1ps

module lutburn_tb ();

    logic [31:0] din, dout;

    localparam clk_period = 10; logic clk = 0; initial forever #(clk_period/2) clk = ~clk;

    lutburn uut (.clk(clk), .din(din), .dout(dout));

    initial begin
        din = 0;
        #(clk_period*1);
        forever begin
            din++;
            #(clk_period*1);
        end
    end

endmodule

