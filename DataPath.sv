`timescale 1ns/1ns
module DataPath (input clk, rst, PCWrite, IFIDWrite, IFflush, MemRead, MemWrite, MemToReg, RegWrite,
                 ALUSrc, RegDst, input[1:0] forwardA, forwardB, PCSrc, input[2:0] ALUOp,
                 output[4:0] Rt, Rs, EXRt, EXRs, MEMWriteReg, WBWriteReg, output[31:0] inst, output equal,
                 EXMemRead, EXRegWrite, MEMRegWrite, WBRegWrite);
                 
  wire[31:0] pcIn, pcOut, MemInst, pcNext, four, RegInst, pcNextOut, WBWriteData, ReadData1, ReadData2,
             SignExtendOut, ShitLeft2Out, JumpAddr, BranchAddr, ReadData1Out, ReadData2Out, immOut, Address,
             mux3Out,A, B, ALUresult, MEMWriteData, ReadData, WBAddress, WBReadData;
  wire[4:0] rtOut, rsOut, rdOut, EXWriteReg;
  wire EXMemWrite, EXMemToReg, EXALUSrc, EXRegDst, WBMemToReg;
  assign four = 32'b00000000000000000000000000000100; 
  // IF Start
  PC pc(clk, rst, PCWrite, pcIn, pcOut);
  InstMem instmem(rst, pcOut, MemInst);
  assign pcNext = pcOut + four;
  // IF End
  IFIDReg IFID(clk, rst, IFIDWrite, IFflush, MemInst, pcNext, RegInst, pcNextOut);
  assign inst = RegInst;
  // ID Start
  RegisterFile regfile(clk, rst, WBRegWrite, RegInst[25:21], RegInst[20:16], WBWriteReg, WBWriteData, ReadData1, ReadData2);
  assign equal = (ReadData1 == ReadData2) ? 1'b1 : 1'b0;
  SignExtend signextend(RegInst[15:0], SignExtendOut);
  ShiftLeft2 ShL2(SignExtendOut, ShitLeft2Out);
  assign JumpAddr = {pcNextOut[31:28], RegInst[25:0], 2'b0};
  assign BranchAddr = ShitLeft2Out + pcNextOut;
  MUX32_3 mux1(pcNext, BranchAddr, JumpAddr, PCSrc, pcIn);
  assign Rt = RegInst[20:16];
  assign Rs = RegInst[25:21];
  // ID End
  IDEXReg IDEX(clk, rst, MemRead, MemWrite, MemToReg, RegWrite, ALUSrc, RegDst,
               ReadData1, ReadData2, SignExtendOut, RegInst[20:16], RegInst[25:21], RegInst[15:11],
               ReadData1Out, ReadData2Out, immOut, rtOut, rsOut, rdOut,
               EXMemRead, EXMemWrite, EXMemToReg, EXRegWrite, EXALUSrc, EXRegDst);
  assign EXRt = rtOut;
  assign EXRs = rsOut;
  // EX Start
  MUX32_3 mux2(ReadData1Out, WBWriteData, Address, forwardA, A);
  MUX32_3 mux3(ReadData2Out, WBWriteData, Address, forwardB, mux3Out);
  ALU alu(A, B, ALUOp, ALUresult);
  MUX32_2 mux4(mux3Out, immOut, EXALUSrc, B);
  MUX5_2 mux5(rtOut, rdOut, EXRegDst, EXWriteReg);
  // EX End
  EXMEMReg EXMEM(clk, rst, EXMemRead, EXMemWrite, EXMemToReg, EXRegWrite,
                 ALUresult, mux3Out, EXWriteReg, Address, MEMWriteData, MEMWriteReg,
                 MEMMemRead, MEMMemWrite, MEMMemToReg, MEMRegWrite);
  // MEM Start
  DataMem datamem(clk, rst, MEMMemRead, MEMMemWrite, Address, MEMWriteData, ReadData);
  // MEM End
  MEMWBReg MEMWB(clk, rst, MEMMemToReg, MEMRegWrite, Address, ReadData, MEMWriteReg,
                 WBAddress, WBReadData, WBWriteReg,
                 WBMemToReg, WBRegWrite);
  // WB Start
  MUX32_2 mux6(WBAddress, WBReadData, WBMemToReg, WBWriteData);
  // WB End
endmodule