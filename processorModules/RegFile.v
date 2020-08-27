`timescale 1ns / 1ps
//***************************************//
// File name: RegFile32x32               //
//                                       //
// Created by Carlos Ornelas on 4/10/20. //
// CECS 440: PROF: Maryam Seyyedhosseini //
//***************************************//
module RegFile(
    clk, reset, rg_wrt_en,
    rg_wrt_addr,rg_rd_addr1,
    rg_rd_addr2,rg_wrt_data,
    rg_rd_data1,rg_rd_data2
);

input clk, reset, rg_wrt_en;

input  [4:0]  rg_wrt_addr; 
input  [4:0]  rg_rd_addr1, rg_rd_addr2;
input  [31:0] rg_wrt_data;

output [31:0] rg_rd_data1, rg_rd_data2;
integer k;
reg [31:0] register[31:0];


always @(posedge clk, posedge reset)
begin
    if(reset) 
    begin
    for (k=0; k<32; k = k+1)
        register[k] = 32'h0;
    end
    
    else 
        if (rg_wrt_en)
            register[rg_wrt_addr] <= rg_wrt_data;
end

assign rg_rd_data1 = register[rg_rd_addr1];
assign rg_rd_data2 = register[rg_rd_addr2];
endmodule