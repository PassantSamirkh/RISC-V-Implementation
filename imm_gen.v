///////////////////////Immediate_generate//////////////////////
`timescale 1ps/1ps 
module imm_gen(imm, inst, imm_sel);
//////////Inputs
input [31:0] inst;
input [2:0] imm_sel;
//////////Output
output reg [31:0] imm;

always @(*)
begin
#50
case (imm_sel)
3'b001 : imm = {{21{inst[31]}}, inst[30:20]};                           //I_type
3'b010 : imm = {{21{inst[31]}}, inst[30:25], inst[11:8],inst[7]};               //S_type
3'b011 : imm = {{20{inst[31]}}, inst[7],inst[30:25],inst[11:8],1'b0};   //B_type
3'b100 : imm = {{11{inst[31]}}, inst[19:12],inst[20],inst[30:21],1'b0}; //J_type
default: imm = 32'bx;                                                   //Illegal
endcase
end
endmodule