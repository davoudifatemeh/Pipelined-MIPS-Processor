`timescale 1ns/1ns
module TB();
  logic clk, rst;
  MIPS pipline(clk, rst);
  initial begin
    clk = 0; rst = 0;
    #400 rst = 1;
    repeat(4) #400 clk = ~clk;
    #400 rst = 0;
    repeat(5000) #400 clk = ~clk;
    $stop;
  end
endmodule
