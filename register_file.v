//////////////Register_File/////////////////
`timescale 1ps/1ps
module register_file (r_data1, r_data2, clk, we, r_add1, r_add2, w_add,w_data);
//////////Inputs		
input clk, we; 
input [4:0] r_add1, r_add2, w_add; 
input [31:0] w_data; 
/////////Output
output [31:0] r_data1, r_data2; 

reg [31:0] RF [0:31]; 
///////////Data_write///////////
always @ (posedge clk)
begin #50
if (we)
	RF[w_add]<= w_data; 
end 
//////////Data_read///////////
assign #50 r_data1 = (r_add1==0)? 0 : RF[r_add1];
assign #50 r_data2 = (r_add2==0)? 0 : RF[r_add2];

endmodule