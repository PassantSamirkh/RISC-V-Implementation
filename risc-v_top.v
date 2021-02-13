///////////////////////riscv_top///////////////
`timescale 1ps/1ps
module riscv_top(clk, rset, inst, MEM_rData, pc, MEM_addr, MEM_wDATA, dm_we);
////////Inputs
input clk;
input rset;
input [31:0] inst;
input [31:0] MEM_rData;
///////Outputs
output [31:0] pc;
output [7:0] MEM_addr;
output [31:0] MEM_wDATA;
output dm_we ;

wire beq, pc_sel, RF_we, a_sel, b_sel;
wire [2:0] imm_sel;
wire [3:0] alu_sel;
wire [1:0] wb_sel ;

Control_Unit ctrl (.inst(inst),
                   .beq(beq),
				   .pc_sel(pc_sel),
				   .imm_sel(imm_sel),
				   .RF_we(RF_we),
				   .a_sel(a_sel),
				   .b_sel(b_sel),
				   .alu_sel(alu_sel),
				   .dm_we(dm_we),
				   .wb_sel(wb_sel));
				   
datapath dp (.clk(clk),
             .rset(rset),
			 .pc_sel(pc_sel),
			 .imm_sel(imm_sel),
			 .wb_sel(wb_sel),
			 .RF_we(RF_we),
			 .a_sel(a_sel),
			 .b_sel(b_sel),
			 .alu_sel(alu_sel),
			 .beq(beq),
			 .inst(inst),
			 .pc(pc),
			 .MEM_addr(MEM_addr),
			 .MEM_rData(MEM_rData),
			 .MEM_wDATA(MEM_wDATA));
					   
				   
				   
endmodule				   