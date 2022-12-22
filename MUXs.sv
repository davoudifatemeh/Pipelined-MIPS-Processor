`timescale 1ns/1ns
module MUX32_2(input[31:0] A, B, input sel, output logic[31:0] q);
  always @(A, B, sel) begin
    q = 32'b0;
    case(sel)
      1'b0: q = A;
      1'b1: q = B;
    endcase
  end
endmodule

module MUX32_3(input[31:0] A, B, C, input[1:0] sel, output logic[31:0] q);
  always @(A, B, C, sel) begin
    q = 32'b0;
    case(sel)
      2'b0: q = A;
      2'b01: q = B;
      2'b10: q = C;
    endcase
  end
endmodule

module MUX5_2(input[4:0] A, B, input sel, output logic[4:0] q);
  always @(A, B, sel) begin
    q = 5'b0;
    case(sel)
      1'b0: q = A;
      1'b1: q = B;
    endcase
  end
endmodule
