///////////////Program_counter/////////////////////
`timescale 1ps/1ps 

module program_counter(d_out, clk, rset, d_in);
/////////Inputs
input clk;
input rset;
input [31:0] d_in;
////////Output
output reg [31:0] d_out;

always @(posedge clk, posedge rset)
begin 
#50
if (rset)
	d_out <= 0;
else 
	d_out <= d_in;	
end
endmodule
