`timescale 1ns/1ns
module InstMem (input rst, input[31:0] Address, output logic[31:0] Inst);
  logic[31:0] Insts[0:256];
  always @(posedge rst)begin
    $readmemb("Inst.txt", Insts);
  end
  always @(Address) begin
    Inst = 32'b0;
    Inst = Insts[Address];
  end
endmodule
