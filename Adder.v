//////////////Adder//////////////
`timescale 1ps/1ps
module adder (sum, a,b);
//////////Inputs
input [31:0] a,b;
/////////Output
output [31:0] sum;
assign #10 sum = a + b;
endmodule 


