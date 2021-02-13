////////////////////Mux/////////////////////////
`timescale 1ps/1ps
module mux(out,in1,in2,sel);
/////////Inputs
input [31:0] in1;
input [31:0] in2;
input sel;
////////Output
output reg [31:0] out;

always @(*)
begin
#10
if(!sel)
	out <= in1;
else
	out <= in2;
end
endmodule	
