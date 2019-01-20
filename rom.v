`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module rom(data, addr, read, ena);
input read, ena;
input [7:0] addr;
output [7:0] data;
 
reg [7:0] memory[255:0];


// note: Decimal number in the bracket
initial begin
	memory[0] = 8'b000_00000;	//NOP
	
	// [ins] [target_reg_addr] [from_rom_addr]
	memory[1] = 8'b001_00001;	//LDO s1
	memory[2] = 8'b010_00001;	//rom(65)	//rom[65] -> reg[1]
	memory[3] = 8'b001_00010;	//LDO s2
	memory[4] = 8'b010_00010;	//rom(66)
	memory[5] = 8'b001_00011;	//LDO s3
	memory[6] = 8'b010_00011;	//rom(67)

	memory[7] = 8'b100_00001;	//PRE s1
	memory[8] = 8'b101_00010;	//ADD s2
	memory[9] = 8'b110_00001;	//LDM s1
	
	memory[10] = 8'b011_00001;	//STO s1
	memory[11] = 8'b000_00001;	//ram(1)
	memory[12] = 8'b010_00010;	//LDA s2
	memory[13] = 8'b000_00001;	//ram(1)
	
	memory[14] = 8'b100_00011;	//PRE s3
	memory[15] = 8'b101_00010;	//ADD s2
	memory[16] = 8'b110_00011;	//LDM s3
	
	memory[17] = 8'b011_00011;	//STO s3
	memory[18] = 8'b000_00010;	//ram(2)
	memory[19] = 8'b111_00000;	//HLT
	
	memory[65] = 8'b001_00101;	//37
	memory[66] = 8'b010_11001;	//89
	memory[67] = 8'b001_10101;	//53
end


assign data = (read&&ena)? memory[addr]:8'hzz;	

endmodule
