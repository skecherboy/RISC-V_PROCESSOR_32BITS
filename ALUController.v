`timescale 1ns / 1ps
//************************************************************************//
// File name: processor                                                   //
//                                                                        //
// Created by Carlos Ornelas on 5/07/20.                                  //
// CECS 440: PROF: Maryam Seyyedhosseini                                  //                   
//                                                                        //
// NOTES:                                                                 //
//  This is the Top module to connect the Controller, Alu Controller      //
// and Datapath together. The Two controllers are built around            //
// a truth table given to the class by Professor Seyyedhosseini           //
// The controller controls all read/write operations to the Datapath      //
// while the ALU controller, as the name suggests, gets the opcode        //
// and alu operation and sends it to the ALU within the Datapath module   //
// Lastly, the Datapath sends out the result of the operation.            // 
//************************************************************************//


module ALUController(ALUOp, 
                     Funct7, Funct3,
                     Operation );
    
    input  [1:0] ALUOp;
    input  [6:0] Funct7;
    input  [2:0] Funct3;
    output [3:0] Operation;
    
    reg [3:0] Operation;
    
    //NOTE USE THE TRUTH TABLE GIVEN IN THE LAB TO CREATE THIS CASE STATEMENT
   
    always@(*) begin
        case({Funct3,ALUOp})
            5'b11110 : Operation = 4'b0000;     // and 
            5'b11010 : Operation = 4'b0001;     // or 
            5'b10010 : Operation = 4'b1100;     // nor 
            5'b01010 : Operation = 4'b0111;     // Set less than 
            5'b00010 : if(Funct7 == 7'h00)       Operation = 4'b0010; // 
                       else if (Funct7 == 7'h20) Operation = 4'b0110; // subtraction 
            5'b11100 : Operation = 4'b0000;     // andimm
            5'b11000 : Operation = 4'b0001;     // orimm
            5'b10000 : Operation = 4'b1100;     // norimm
            5'b01000 : Operation = 4'b0111;     // setlessthenimm
            5'b00000 : Operation = 4'b0010;     // addimm
            5'b01001 : Operation = 4'b0010;     // load word / store word
            default  : Operation = 4'b0000;     // default (and)
        endcase
    end
    
endmodule

