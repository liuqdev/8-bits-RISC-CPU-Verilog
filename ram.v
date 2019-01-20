`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ram(data, addr, ena, read, write);
input ena, read, write;
input [7:0] addr;
inout [7:0] data;

reg [7:0] ram[255:0];

assign data = (read&&ena)? ram[addr]:8'hzz;		// read data from RAM

always @(posedge write) begin	// write data to RAM
	ram[addr] <= data;
end

endmodule
