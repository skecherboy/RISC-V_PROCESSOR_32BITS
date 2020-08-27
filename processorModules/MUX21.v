// Module definition
module MUX21 (
D0 , D1 , S , Y
 );

input S; // select line
input [31:0] D0;
input [31:0] D1;

output[31:0] Y;

assign Y = (S==1'b1) ? D1 : D0;

endmodule // Mux21