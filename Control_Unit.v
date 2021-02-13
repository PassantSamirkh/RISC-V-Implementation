///////////////////control_unit///////////////////
`timescale 1ps/1ps 
module Control_Unit(pc_sel , RF_we, dm_we, b_sel, a_sel, wb_sel, imm_sel , alu_sel, inst, beq);
///////Inputs
input [31:0] inst;
input beq; 

//////Outputs
output reg pc_sel , RF_we, dm_we, b_sel , a_sel ;
output reg [1:0] wb_sel; 
output reg [2:0] imm_sel; 
output reg [3:0] alu_sel; 

//////parameters	
	
parameter  LW     =7'b000_0011 ; 
parameter  SW     =7'b010_0011 ; 
parameter  OP_I   =7'b001_0011 ;      //ADDI , ANDI , ORI 
parameter  OP     =7'b011_0011 ;      //ADD , AND , OR
parameter  JAL    =7'b110_1111 ; 
parameter  JALR   =7'b110_0111 ; 
parameter  BRANCH =7'b110_0011 ; 
	

always @(*)
begin
#50
case(inst[6:0]) 
				
///////I_type//////				
	LW: begin 
		pc_sel=0; 
		RF_we=1; 
		dm_we=0; 
		a_sel =0;
		b_sel =1;
		wb_sel=2'b00; 
		imm_sel = 3'b001; 
		alu_sel = 4'b0000;
//////S_type//////				 
 end	
	SW: begin 
		pc_sel=0; 
		RF_we=0; 
		dm_we=1; 
		a_sel =0;
		b_sel =1;
		wb_sel=2'b00; 
		imm_sel = 3'b010; 
		alu_sel = 4'b0000;				 
end 
///////I_type//////
	OP_I: begin 
		pc_sel=0; 
		RF_we=1; 
		dm_we=0; 
		a_sel =0;
		b_sel =1;
		wb_sel=2'b01; 
		imm_sel = 3'b001; 
		alu_sel = {1'b0, inst[14:12]};		 
end
///////R_type//////
	OP: begin //Add, Sub, OR
		pc_sel=0; 
		RF_we=1; 
		dm_we=0; 
		a_sel =0;
		b_sel =0;
		wb_sel=2'b01; 
		imm_sel = 3'b000; 
		alu_sel = {inst[30], inst[14:12]};		 
end
//////J_type//////
	JAL:  begin
		pc_sel=1; 
		RF_we=1; 
		dm_we=0; 
		a_sel =1;
		b_sel =1;
		wb_sel=2'b10; 
		imm_sel = 3'b100; 
		alu_sel = 4'b0000;				
end 
/////J_type//////
	JALR:  begin
		pc_sel=1; 
		RF_we=1; 
		dm_we=0; 
		a_sel =0;
		b_sel =1;
		wb_sel=2'b10; 
		imm_sel = 3'b001; 
		alu_sel = 4'b0000;				
 end 
 /////B_type/////
    BRANCH: begin
		pc_sel= inst[12]?!beq  : beq ; 
		RF_we=1; 
		dm_we=0; 
		a_sel =1;
		b_sel =1;
		wb_sel=2'b00; 
		imm_sel = 3'b011; 
		alu_sel = 4'b0000;
						
end
/////Illigal_operation/////
	default : begin
		pc_sel=1'bx; 
		RF_we=1'b0; 
		dm_we=1'b0; 
		a_sel =1'bx;
		b_sel =1'bx;
		wb_sel=2'b00; 
		imm_sel = 3'bxxx; 
		alu_sel = 4'bxxxx;		
end 				 
endcase 
end 				   
endmodule