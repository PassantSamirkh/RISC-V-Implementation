/////////////////////////////datapath//////////////////////////
`timescale 1ps/1ps 
module datapath(clk, rset, pc_sel, imm_sel, RF_we, a_sel, b_sel, alu_sel, wb_sel, beq, inst, pc, MEM_addr, MEM_rData, MEM_wDATA);
///////Inputs			
input clk , rset, pc_sel , a_sel , b_sel , RF_we; 
input [1:0] wb_sel ;
input [2:0] imm_sel; 
input [3:0] alu_sel ; 
input [31:0] inst , MEM_rData; 
//////Outputs
output beq; 
output [31:0] pc, MEM_wDATA; 
output [7:0] MEM_addr;
/////wires
wire [31:0] pc_next, pcplus_4, pc_i;
wire [31:0] rs1, rs2, wbdata1, wbdata2;
wire [31:0] imm;
wire [31:0] ALU_rs1, ALU_rs2, ALU_rd;

assign pc = pc_i;
assign MEM_addr = ALU_rd [7:0];
assign MEM_wDATA = rs2 ;

program_counter pcreg(.clk(clk),
                      .rset(rset),
					  .d_in(pc_next),
					  .d_out(pc_i));
					  
adder pcadd(.a(pc_i),
            .b(32'b100),
			.sum(pcplus_4));


mux pcnextmux1(.in1(pcplus_4),
               .in2(ALU_rd),
               .out(pc_next),
               .sel(pc_sel));
			   
register_file rf(.clk(clk),
                 .we(RF_we),
                 .r_add1(inst[19:15]),
                 .r_add2(inst[24:20]),
                 .w_add(inst[11:7]),
				 .r_data1(rs1),
				 .r_data2(rs2),
				 .w_data(wbdata2));
				  
branch_comp brcomp(.r_data1(rs1),
                   .r_data2(rs2),
                   .beq(beq));

imm_gen immgen(.inst(inst),
               .imm_sel(imm_sel),
               .imm(imm));

mux amux(.in1(rs1),
         .in2(pc_i),
         .out(ALU_rs1),
         .sel(a_sel));

mux bmux(.in1(rs2),
         .in2(imm),
         .out(ALU_rs2),
         .sel(b_sel));		 
					
					
					
ALU_riscv alu(.rs1(ALU_rs1),                      
              .rs2(ALU_rs2),
			  .rd(ALU_rd),
			  .alu_sel(alu_sel));
			  
			  
mux wbmux1(.in1(MEM_rData),
           .in2(ALU_rd),
           .out(wbdata1),
           .sel(wb_sel[0]));	
		 
mux wbmux2(.in1(wbdata1),
           .in2(pcplus_4),
           .out(wbdata2),
           .sel(wb_sel[1]));			 
		 
		 


endmodule

