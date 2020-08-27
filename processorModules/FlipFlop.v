`timescale 1ns / 1ps
//***************************************//
// File name: FlipFlop_Sync              //
//                                       //
// Created by Carlos Ornelas on 4/10/20. //
// CECS 440: PROF: Maryam Seyyedhosseini //
//***************************************//
module FlipFlop(clk, reset,d,q);
input clk, reset;
input  [7:0] d;
output reg [7:0] q;

always @(posedge clk)
begin
    if (reset)
        q <=7'b0;
    else
        q <= d;
end

endmodule
