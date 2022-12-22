`timescale 1ns/1ns
module HazardUnit(input[5:0] opc, input[4:0] EXRt, EXRd, MEMRd, rs, rt, input EXMemRead, MEMMemRead, EXRegWrite,
                  output logic IFIDWrite, PCWrite, SelCtrl, hazard);
                  
  always @(EXRt, EXRd, rs, rt, EXMemRead, opc, MEMRd, MEMMemRead, EXRegWrite) begin
    {IFIDWrite, PCWrite, SelCtrl, hazard} = 4'b1110;

    if (EXMemRead && (EXRt == rt || EXRt == rs))
      {IFIDWrite, PCWrite, SelCtrl} = 3'b000;

    if (EXRegWrite && ~EXMemRead && (EXRd == rt || EXRd == rs) && (opc == 6'b000100 || opc == 6'b000101))
      {IFIDWrite, PCWrite, SelCtrl, hazard} = 4'b0001;

    if (EXMemRead && (EXRt == rt || EXRt == rs) && (opc == 6'b000100 || opc == 6'b000101))
      {IFIDWrite, PCWrite, SelCtrl, hazard} = 4'b0001;

    if (MEMMemRead && (MEMRd == rt || MEMRd == rs) && (opc == 6'b000100 || opc == 6'b000101))
      {IFIDWrite, PCWrite, SelCtrl, hazard} = 4'b0001;

  end
endmodule