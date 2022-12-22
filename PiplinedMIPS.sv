`timescale 1ns/1ns
module MIPS(input clk, rst);
  wire PCWrite, IFIDWrite, IFflush, MemRead, MemWrite, MemToReg, RegWrite, ALUSrc, RegDst,
       equal, EXMemRead, EXRegWrite, MEMRegWrite, WBRegWrite, SelCtrl, Branch, hazard;
  wire[1:0] PCSrc, forwardA, forwardB;
  wire[2:0] ALUOp;
  wire[4:0] Rt, Rs, EXRt, EXRs, MEMWriteReg, WBWriteReg;
  wire[31:0] Inst;
  
  DataPath dp(clk, rst, PCWrite, IFIDWrite, IFflush, MemRead, MemWrite, MemToReg, RegWrite, ALUSrc, RegDst, 
              forwardA, forwardB, PCSrc, ALUOp, Rt, Rs, EXRt, EXRs, MEMWriteReg, WBWriteReg, Inst, equal,
              EXMemRead, EXRegWrite, MEMRegWrite, WBRegWrite);
              
  Controller c(Inst, equal, SelCtrl, hazard, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, 
               Branch, IFflush, PCSrc, ALUOp);
                  
  //HazardUnit hu(EXMemRead, Branch, EXRegWrite, MEMRegWrite, WBRegWrite, Rs, Rt, MEMWriteReg, EXRt, WBWriteReg,
                //PCWrite, IFIDWrite, SelCtrl);
  HazardUnit hu(Inst[31:26], EXRt, EXRegWrite, MEMRegWrite, Rs, Rt, EXMemRead, MEMMemRead, EXRegWrite,
                IFIDWrite, PCWrite, SelCtrl, hazard);
                
  ForwardUnit fu(MEMRegWrite, WBRegWrite, MEMWriteReg, EXRs, WBWriteReg, EXRt, forwardA, forwardB);
endmodule
                   