module core(clk, rst);	// Top-level entity(except core-tb)
input clk, rst;

wire write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena;
wire ram_write, ram_read, rom_read, ad_sel;

wire [1:0] fetch;
wire [7:0] data, addr;
wire [7:0] accum_out, alu_out;
wire [7:0] ir_ad, pc_ad;
wire [4:0] reg_ad;
wire [2:0] ins;

ram RAM1(.data(data), .addr(addr), .ena(ram_ena), .read(ram_read), .write(ram_write));  //module ram(data, addr, ena, read, write);

rom ROM1(.data(data), .addr(addr), .ena(rom_ena), .read(rom_read));					//module rom(data, addr, read, ena);

addr_mux MUX1(.addr(addr), .sel(ad_sel), .ir_ad(ir_ad), .pc_ad(pc_ad));					//module addr_mux(addr, sel, ir_ad, pc_ad); 

counter PC1(.pc_addr(pc_ad), .clock(clk), .rst(rst), .en(PC_en));						//module counter(pc_addr, clock, rst, en);

accum ACCUM1(.out(accum_out), .in(alu_out), .ena(ac_ena), .clk(clk), .rst(rst)); 		//module accum( in, out, ena, clk, rst); 

alu ALU1(.alu_out(alu_out), .alu_in(data), .accum(accum_out), .op(ins));				// module alu(alu_out, alu_in, accum, op);

reg_32 REG1(.in(alu_out), .data(data), .write(write_r), .read(read_r), .addr({ins,reg_ad}), .clk(clk));	//module reg_32(in, data, write, read, addr, clk);
//reg_32 REG1(.in(alu_out), .data(data), .write(write_r), .read(read_r), .addr(reg_ad), .clk(clk));		//module reg_32(in, data, write, read, addr, clk);

ins_reg IR1(.data(data), .fetch(fetch), .clk(clk), .rst(rst), .ins(ins), .ad1(reg_ad), .ad2(ir_ad));	//module ins_reg(data, fetch, clk, rst, ins, ad1, ad2);

//module machine(ins, clk, rst, write_r, read_r, PC_en, fetch, ac_ena, ram_ena, rom_ena,ram_write, ram_read, rom_read, ad_sel);
controller CONTROLLER1(.ins(ins), 
					.clk(clk), 
					.rst(rst), 
					.write_r(write_r), 
					.read_r(read_r), 
					.PC_en(PC_en), 
					.fetch(fetch), 
					.ac_ena(ac_ena), 
					.ram_ena(ram_ena), 
					.rom_ena(rom_ena),
					.ram_write(ram_write), 
					.ram_read(ram_read), 
					.rom_read(rom_read), 
					.ad_sel(ad_sel)
					);
					

endmodule



