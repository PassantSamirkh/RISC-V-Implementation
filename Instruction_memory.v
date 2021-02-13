/////////////////Instruction_Memory///////////////
`timescale 1ps/1ps 
module IMEM (inst, add);
/////////Input
input [7:0] add;
////////Output
output [31:0] inst;

reg [31:0] ROM [0:255];
initial
$readmemh("fib.txt",ROM);
assign #100 inst = ROM[add];

endmodule