`timescale 1 ns / 1 ps

module heater_tb();    
    parameter Nsrl  = 2;
    parameter Nbram = 2;
    parameter Ndsp  = 3;
    parameter Npipe = 5;
    
    logic               enable;
    logic               err_clear;
    logic               error;
    
    localparam clk_period = 10; logic clk = 0; initial forever #(clk_period/2) clk = ~clk;

    initial begin 
        err_clear = 1;
        enable = 0;
        #(clk_period*10);
        enable = 1;
        #(clk_period*2500);
        err_clear = 0;
        #(clk_period*10000);
        enable = 0;
    end

    heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) uut (.*);

endmodule

