module axau15_top (
    input  logic       sysclk_p, sysclk_n,
    output logic [1:0] led
);

    localparam int N = 32;
    localparam int Nsrl = 6;
    localparam int Nbram = 4;
    localparam int Ndsp = 12;
    localparam int Npipe = 60; 

    logic clk300, clk100;
    axau15_clock_wiz clock_wiz_inst(.clk100(clk100), .clk300(clk300), .locked(), .clk_in1_p(sysclk_p), .clk_in1_n(sysclk_n));

    logic [N-1:0] heater_error, heater_err_clear, heater_enable;

    genvar i;  
    generate  for (i=0; i<N; i++) begin: gen_code_label  
        heater #(.Nsrl(Nsrl), .Nbram(Nbram), .Ndsp(Ndsp), .Npipe(Npipe)) heater_inst(.clk(clk300), .enable(heater_enable[i]), .error(heater_error[i]), .err_clear(heater_err_clear[i]));
    end  endgenerate 

    artix_vio vio_inst( .clk(clk100), .probe_in0(heater_error), .probe_out0(heater_err_clear), .probe_out1(heater_enable) );

    always_ff @(posedge clk300) led <= heater_error[1:0];
    
endmodule

