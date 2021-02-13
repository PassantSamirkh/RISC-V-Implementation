//////////////////////RISC_v testbench//////////////////////////////////

`timescale 1ps / 1ps

module riscv_tb;

// Inputs
reg clk;
reg rset;
	
// Outputs
wire [31:0] pc;
wire [7:0] MEM_addr;
wire [31:0] MEM_wDATA;
wire dm_we;
wire [31:0] inst;
wire [31:0] MEM_rData;


////////////////////Top_module///////////////////////////////
	riscv_top uut (
		.clk(clk), 
		.rset(rset), 
		.inst(inst), 
		.MEM_rData(MEM_rData), 
		.pc(pc), 
		.MEM_addr(MEM_addr), 
		.MEM_wDATA(MEM_wDATA), 
		.dm_we(dm_we)
	);
////////////////////Instruction_Memory////////////////////////   
	
	IMEM uut2 ( 
	  .add(pc[9:2]),
	  .inst(inst));
///////////////////Data_Memory////////////////////////////////	  
	Mem_data uut3 (
	  .clk(clk),
	  .dm_we(dm_we),
	  .mem_addr(MEM_addr),
	  .mem_wd(MEM_wDATA),
	  .mem_rd(MEM_rData));
	  
	  
	initial begin
		// Initialize Inputs
		#2000 rset = 1;
		
	   #2000 rset = 0;
      end
		
	
  initial
  begin
   clk = 0; end
   
   always begin #2000 clk = ~clk;
  end

      
endmodule

