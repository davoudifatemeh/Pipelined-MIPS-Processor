`timescale 1ns/1ns
module ForwardUnit(input MEMRegWrite, WBRegWrite, input[4:0]  MEMRd, EXRs, WBRd, EXRt,
                   output logic [1:0] forwardA, forwardB);

    always @(MEMRegWrite, MEMRd, EXRs, WBRegWrite, WBRd, EXRt) begin
        {forwardA, forwardB} = 4'b0;
        if(MEMRegWrite == 1'b1 && MEMRd == EXRs && MEMRd != 5'b00000)
            forwardA = 2'b10;
        else if(WBRegWrite == 1'b1 && WBRd == EXRs && WBRd != 5'b00000)
            forwardA = 2'b01;  
        if(MEMRegWrite == 1'b1 && MEMRd == EXRt && MEMRd != 5'b00000)
            forwardB = 2'b10;
        else if(WBRegWrite == 1'b1 && WBRd == EXRt && WBRd != 5'b00000)
            forwardB = 2'b01;           
    end

endmodule