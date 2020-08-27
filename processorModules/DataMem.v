`timescale 1ns / 1ps


module DataMem(MemRead, MemWrite, addr, write_data, read_data  );
integer i;
input MemRead, MemWrite;
input  [8:0]  addr;
input  [31:0] write_data;

output wire [31:0] read_data;
reg  [31:0] mem [127:0];
    
    // To initialize all 128 registers to zero
initial begin
    for(i=0; i<128; i=i+1)begin
        mem[i] = 32'b0;
    end
end

//
always @(*)
begin
    if (MemWrite)
    mem[addr] <= write_data;
end 
// 
assign read_data = MemRead ? mem[addr] : 32'h0;
endmodule
