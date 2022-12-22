`timescale 1ns/1ns
module Controller(input[31:0] Inst, input equal, SelCtrl, hazard, output logic RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, 
                  output logic Branch, IFflush, output logic [1:0]  PCSrc, output logic [2:0] ALUOp);
                  
    always @(Inst, equal, SelCtrl, hazard) begin
        {RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, PCSrc, Branch, ALUOp, IFflush} = 13'b0;
        if(~SelCtrl) begin
          {RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemToReg} = 6'b0;
        end
        else begin
          IFflush = 1'b0;
          case (Inst[31:26])
            6'b000000: begin //R Type
                {RegDst, RegWrite} = 2'b11;
                case(Inst[5:0])
                  6'b100000: ALUOp = 3'b0;
                  6'b100010: ALUOp = 3'b001;
                  6'b100100: ALUOp = 3'b010;
                  6'b100101: ALUOp = 3'b011;
                  6'b101010: ALUOp = 3'b100;
                endcase
            end 
            6'b100011: begin // LW
                {RegWrite, ALUSrc, MemRead, MemToReg} = 4'b1111;
                ALUOp = 3'b0;
            end 
            6'b101011: begin // SW
                {ALUSrc, MemWrite} = 2'b11;
                ALUOp = 3'b0;
            end 
            6'b000100: begin // BE
                Branch = 1'b1;
                if (~hazard) begin
                  PCSrc = equal ? 2'b01 : 2'b00;
                  IFflush = equal;
                end
            end 
            6'b000101: begin // BNE
                if (~hazard) begin
                  PCSrc = ~equal ? 2'b01 : 2'b00;
                  IFflush = ~equal;
                end
            end 
            6'b001000: begin // ADDi
                {RegWrite, ALUSrc} = 2'b11;
                ALUOp = 3'b0;
            end 
            6'b001100: begin // ANDi
                {RegWrite, ALUSrc} = 2'b11;
                ALUOp = 3'b010;
            end 
            6'b000010: begin // J
                PCSrc = 2'b10;
                IFflush = 1'b1;
            end 
          endcase
        end
    end
endmodule
