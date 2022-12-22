`timescale 1ns/1ns
module RegisterFile(input clk, rst, RegWrite, input[4:0] ReadReg1, ReadReg2, WriteReg,
               input[31:0] WriteData, output logic[31:0] ReadData1, ReadData2);
  reg[31:0] R[0:31];
  initial
  begin
    R[0] = 32'b0;
  end
  
  //assign ReadData1 = R[ReadReg1];
  //assign ReadData2 = R[ReadReg2];
  
  always @(negedge clk) begin
    ReadData1 <= R[ReadReg1];
    ReadData2 <= R[ReadReg2];
  end
  
  always @(posedge clk) begin
    if (RegWrite)
      if (WriteReg != 5'b0)
        R[WriteReg] <= WriteData;
  end
endmodule