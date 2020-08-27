module ImmGen (
InstCode ,
ImmOut
);
input [ 31 : 0 ] InstCode ;
output reg [ 31 : 0 ] ImmOut ;

always @( InstCode )
begin
case ( InstCode [6:0] )
//0x03
7'b0000011 :ImmOut = { InstCode [ 31 ] ? {20{1'b1 }} : 20'b0 , InstCode [ 31 : 20 ] };
//0x93 or 0x13
7'b0010011 :ImmOut = { InstCode [ 31 ] ? {20{1'b1 }} : 20'b0 , InstCode [ 31 : 20 ] };
//0x17
7'b0010111 :ImmOut = { InstCode [ 31 : 12 ] , 12'b0 };
//0x23
7'b0100011 :ImmOut = { InstCode [ 31 ] ? {20{1'b1 }} : 20'b0 , InstCode [ 31 : 25 ] , InstCode [ 11 : 7 ] };
//0x33
//7'b0110011 :ImmOut = { InstCode [ 31 ] ? {20{1'b1 }} : 20'b0 , InstCode [ 31 : 20 ] }; 

default :ImmOut = {32'b0 };
endcase
end
endmodule