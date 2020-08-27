    `timescale 1ns / 1ps
//****************************************************************//
// File name: alu_32                                              //
//                                                                //
// Created by Carlos Ornelas on 3/22/20.                          //
// CECS 440: PROF: Maryam Seyyedhosseini                          //                   
//                                                                //
// NOTES:                                                         //
// Module takes two inputs: A_in & B_in                           //
// Alu_Sel is the 4-bit opcode selection which determines what    //
// operation is executed on the above inputs.                     //
// The Status Flags are: Carry Out, Overflow, and Zero.           //
// Flags are determined by conditional statements.                //
// If an operation does not qualify for a flag, then that flag    // 
// will get a zero for that operation.                            //
// All operations are signed operations.                          // 
// Lastly, the result is ALU_Out and is 32-bits.                  //
//****************************************************************//

module alu_32(A_in, B_in, ALU_Sel,
              ALU_Out, Carry_Out, Zero, Overflow);

input [31:0] A_in, B_in;
input [3:0] ALU_Sel;

output reg [31:0] ALU_Out;
output reg Carry_Out, Zero, Overflow;
integer intS, intT;
always @(A_in or B_in or ALU_Sel)
begin 
    case(ALU_Sel)
       //***AND***//
       4'b0000:
        begin 
        ALU_Out = A_in & B_in;
        Carry_Out = 1'b0;
        Overflow = 1'b0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end
        
        //*** OR ***//
        4'b0001:
        begin
        ALU_Out = A_in | B_in;
        Carry_Out = 1'b0;
        Overflow = 1'b0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end 
        
        //***Addition***//
        4'b0010: 
        begin
        {Carry_Out,ALU_Out} = A_in + B_in;
        Overflow = A_in[31] != B_in[31] ? 0: B_in[31] == ALU_Out[31]? 0: 1;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end 
       
        //***Subtraction***//    
        4'b0110:
        begin
        {Carry_Out, ALU_Out} = A_in - B_in;
        Overflow = A_in[31] == B_in[31] ? 0: B_in[31] == ALU_Out[31] ? 1: 0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end
        
        //***Set Less Than***///
        4'b0111:
        begin
        intS = A_in;
        intT = B_in;
        if (intS < intT)
            ALU_Out = 1;
        else
            ALU_Out = 0;
        Carry_Out = 1'b0;
        Overflow = 1'b0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end
        
        //***NOR***//
        4'b1100:
        begin
        ALU_Out = ~(A_in | B_in);
        Carry_Out = 1'b0;
        Overflow = 1'b0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end
    
        //***Equal Comp***//
        4'b1111:
        begin
        ALU_Out = A_in == B_in ? 1: 0; 
        Carry_Out = 1'b0;
        Overflow = 1'b0;
        Zero = (ALU_Out == 32'b0)?  1: 0;
        end
    endcase
end

endmodule
