`timescale 1ns/1ns
module SignExtend(input[15:0] A, output logic[31:0] B);
  always @(A) begin
    if (A[15] == 1'b1)
      B = {16'b1111111111111111, A};
    else
      B = {16'b0, A};
  end
endmodule