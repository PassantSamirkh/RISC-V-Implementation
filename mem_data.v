///////////MemoryData////////////
`timescale 1ps/1ps

module Mem_data (mem_rd, clk, dm_we, mem_addr, mem_wd);
/////Inputs
input clk ;
input dm_we;
input [7:0] mem_addr;
input [31:0] mem_wd;
////Output
output [31:0] mem_rd;

reg [31:0] RAM [0:255];

assign #100 mem_rd = RAM[mem_addr] ;

always @ (posedge clk)
begin
if (dm_we) 
	RAM[mem_addr] <= #100 mem_wd;
end

endmodule
