//////////////Branch_Comparator///////////////
`timescale 1ps / 1ps
module branch_comp(r_data1,r_data2,beq);
output reg  beq ;
input [31:0] r_data1,r_data2;

always @(*)
begin #10
if (r_data1 == r_data2)	
	beq = 1 ; 
else
	beq =0 ; 
end
endmodule
