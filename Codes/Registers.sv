`timescale 1ns/1ns
module IFIDReg(input clk, rst, IFIDWrite, flush, input[31:0] Inst, pcNext, output logic[31:0] InstOut, pcNextOut);
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      InstOut <= 32'b0;
      pcNextOut <= 32'b0;
    end
    if (flush) begin
      InstOut <= 32'b0;
      pcNextOut <= 32'b0;
    end
    else if (IFIDWrite) begin
      InstOut <= Inst;
      pcNextOut <= pcNext;
    end
  end
endmodule

module IDEXReg(input clk, rst, MemRead, MemWrite, MemToReg, RegWrite, ALUSrc, RegDst,
               input[31:0] ReadData1, ReadData2, imm, input[4:0] rt, rs, rd,
               output logic[31:0] ReadData1Out, ReadData2Out, immOut, output logic[4:0] rtOut, rsOut, rdOut,
               output logic MemReadOut, MemWriteOut, MemToRegOut, RegWriteOut, ALUSrcOut, RegDstOut);
  always @(posedge clk, posedge rst) begin
    if (rst)begin
      MemReadOut <= 1'b0;
      MemWriteOut <= 1'b0;
      MemToRegOut <= 1'b0;
      RegWriteOut <= 1'b0;
      ALUSrcOut <= 1'b0;
      RegDstOut <= 1'b0;
      ReadData1Out <= 32'b0;
      ReadData2Out <= 32'b0;
      immOut <= 32'b0;
      rtOut <= 5'b0;
      rsOut <= 5'b0;
      rdOut <= 5'b0;
    end
    else begin
      MemReadOut <= MemRead;
      MemWriteOut <= MemWrite;
      MemToRegOut <= MemToReg;
      RegWriteOut <= RegWrite;
      ALUSrcOut <= ALUSrc;
      RegDstOut <= RegDst;
      ReadData1Out <= ReadData1;
      ReadData2Out <= ReadData2;
      immOut <= imm;
      rtOut <= rt;
      rsOut <= rs;
      rdOut <= rd;
    end
  end
endmodule

module EXMEMReg (input clk, rst, MemRead, MemWrite, MemToReg, RegWrite,
                 input[31:0] ALUresult, ReadData2, input[4:0] WriteAddr,
                 output logic[31:0] ALUresultOut, ReadData2Out, output logic[4:0] WriteAddrOut,
                 output logic MemReadOut, MemWriteOut, MemToRegOut, RegWriteOut);
  always @(posedge clk, posedge rst) begin
    if (rst)begin
      MemReadOut <= 1'b0;
      MemWriteOut <= 1'b0;
      MemToRegOut <= 1'b0;
      RegWriteOut <= 1'b0;
      ALUresultOut <= 32'b0;
      ReadData2Out <= 32'b0;
      WriteAddrOut <= 5'b0;
    end
    else begin
      MemReadOut <= MemRead;
      MemWriteOut <= MemWrite;
      MemToRegOut <= MemToReg;
      RegWriteOut <= RegWrite;
      ALUresultOut <= ALUresult;
      ReadData2Out <= ReadData2;
      WriteAddrOut <= WriteAddr;
    end
  end
endmodule

module MEMWBReg (input clk, rst, MemToReg, RegWrite,
                 input[31:0] Address, ReadData, input[4:0] WriteAddr,
                 output logic[31:0] AddressOut, ReadDataOut, output logic[4:0] WriteAddrOut,
                 output logic MemToRegOut, RegWriteOut);
  always @(posedge clk, posedge rst) begin
    if (rst)begin
      MemToRegOut <= 1'b0;
      RegWriteOut <= 1'b0;
      AddressOut <= 32'b0;
      ReadDataOut <= 32'b0;
      WriteAddrOut <= 5'b0;
    end
    else begin
      MemToRegOut <= MemToReg;
      RegWriteOut <= RegWrite;
      AddressOut <= Address;
      ReadDataOut <= ReadData;
      WriteAddrOut <= WriteAddr;
    end
  end
endmodule