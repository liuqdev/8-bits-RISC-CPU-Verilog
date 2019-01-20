`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alu(alu_out, alu_in, accum, op);//  arithmetic logic unit
    // to perform arithmetic and logic operations.
input [2:0] op;
input [7:0] alu_in,accum;
output reg [7:0] alu_out;

parameter 	NOP=3'b000,
			LDO=3'b001,
			LDA=3'b010,
			STO=3'b011,
			PRE=3'b100,
			ADD=3'b101,
			LDM=3'b110,
			HLT=3'b111;


always @(*) begin
		casez(op)
		NOP:	alu_out = accum;
		HLT:	alu_out = accum;
		LDO:	alu_out = alu_in;
		LDA:	alu_out = alu_in;
		STO:	alu_out = accum;
		PRE:	alu_out = alu_in;
		ADD:	alu_out = accum+alu_in;
		LDM:	alu_out = accum;
		default:	alu_out = 8'bzzzz_zzzz;
		endcase
end
			 
			
endmodule
