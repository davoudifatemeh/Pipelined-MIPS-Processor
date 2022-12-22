`timescale 1ns/1ns
module PC(input clk, rst, en, input[31:0] pcIn, output logic[31:0] pcOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      pcOut <= 32'b0;
    else if (en)
      pcOut <= pcIn;
  end
endmodule
