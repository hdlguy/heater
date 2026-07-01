
module artix_top_tb ();

    logic       clk_in;
    logic [7:0] led;

    //localparam time clk_period=10; logic clk=0;  always #(clk_period/2) clk=~clk;
    localparam clk_period = 10; logic clk = 0; initial forever #(clk_period/2) clk = ~clk;
    assign clk_in = clk;

    artix_top uut (.*);
    

endmodule


