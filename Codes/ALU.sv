`timescale 1ns/1ns
module ALU(input[31:0] A, B, input[2:0] sel, output reg[31:0] res);
  always @(A, B, sel) begin
    res = 32'b0;
    case (sel)
      3'b000: res = A + B;
      3'b001: res = A - B;
      3'b010: res = A & B;
      3'b011: res = A | B;
      3'b100: res = (A < B) ? 32'b00000000000000000000000000000001 : 32'b0;
    endcase
  end
  //assign zero = (res == 32'b0) ? 1 : 0;
endmodule
