`timescale 1ns / 1ps
//************************************************************************//
// File name: processor                                                   //
//                                                                        //
// Created by Carlos Ornelas on 5/07/20.                                  //
// CECS 440: PROF: Maryam Seyyedhosseini                                  //                   
//                                                                        //
// NOTES:                                                                 //
//  This is the controller module. Its purpose is to control the main     //
//  function of the code 
//************************************************************************//


module Controller(Opcode, ALUSrc, 
                  MemtoReg, RegWrite, MemRead, MemWrite, 
                  ALUOp  );

input [6:0] Opcode;
output ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
output [1:0] ALUOp;

reg ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
reg [1:0] ALUOp;

// Look @ truth table
// This is how to format the Controller
// and control its behaivior. 
always@(*)
    case(Opcode)
    // load word
      7'b0000011 : begin                  
                     MemtoReg = 1'b1;
                     MemWrite = 1'b0;
                     MemRead = 1'b1;
                     ALUSrc = 1'b1;
                     RegWrite = 1'b1;
                     ALUOp = 2'b01;
                     end
    // store word
        7'b0100011 : begin                  
                     MemtoReg = 1'b0;
                     MemWrite = 1'b1;
                     MemRead = 1'b0;
                     ALUSrc = 1'b1;
                     RegWrite = 1'b0;
                     ALUOp = 2'b01;
                     end 
      // Immediate type instructions for RISC-V
        7'b0010011 : begin                  
                     MemtoReg = 1'b0;
                     MemWrite = 1'b0;
                     MemRead = 1'b0;
                     ALUSrc = 1'b1;
                     RegWrite = 1'b1;
                     ALUOp = 2'b00;
                     end
      //  Register type instruction
        7'b0110011 :begin                   
                     MemtoReg = 1'b0;
                     MemWrite = 1'b0;
                     MemRead = 1'b0;
                     ALUSrc = 1'b0;
                     RegWrite = 1'b1;
                     ALUOp = 2'b10;
                     end
      // Signals back to default "state" inactive 0
        default    :begin                   
                     MemtoReg = 1'b0;
                     MemWrite = 1'b0;
                     MemRead = 1'b0;
                     ALUSrc = 1'b0;
                     RegWrite = 1'b0;
                     ALUOp = 2'b00;
                     end
                     
    endcase
    
endmodule

