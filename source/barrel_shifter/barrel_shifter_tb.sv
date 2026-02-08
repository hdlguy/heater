`timescale 1ns / 1ps

module barrel_shifter_tb ();

    localparam integer W = 32;
    localparam integer Wsh = $clog2(W);

    logic [Wsh-1:0]     shift;
    logic [W-1:0]       din, dout;

    localparam clk_period = 10; logic clk = 0; initial forever #(clk_period/2) clk = ~clk;

    barrel_shifter #(.W(W)) uut (.clk(clk), .shift(shift), .din(din), .dout(dout));

    initial begin
    
        shift = 4;
        din = 0;
        #(clk_period*1);
        for (int i=0; i<100; i++) begin
            din = i;
            #(clk_period*10);
        end
        
        shift = 0;
        din = 0;
        #(clk_period*1);
        for (int i=0; i<100; i++) begin
            din = i;
            #(clk_period*10);
        end
        
        shift = W-4;
        din = 0;
        #(clk_period*1);
        for (int i=0; i<100; i++) begin
            din = i;
            #(clk_period*10);
        end
        
    end

endmodule

