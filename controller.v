module controller_purify(ins, clk, rst, write_r, read_r, PC_en, fetch, ac_ena, ram_ena, rom_ena,ram_write, ram_read, rom_read, ad_sel);

input clk, rst;   		// clock, reset
input [2:0] ins;  		// instructions, 3 bits, 8 types

// Enable signals
output reg write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena;

// ROM: where instructions are storaged. Read only.
// RAM: where data is storaged, readable and writable.
output reg ram_write, ram_read, rom_read, ad_sel;

output reg [1:0] fetch;		// 01: to fetch from RAM/ROM; 10: to fetch from REG

// State code(current state)
reg [3:0] state;		// current state
reg [3:0] next_state; 	// next state


// instruction code
parameter 	NOP=3'b000, // no operation
			LDO=3'b001,	// load ROM to register
			LDA=3'b010, // load RAM to register
			STO=3'b011, // Store intermediate results to accumulator
			PRE=3'b100, // Prefetch Data from Address
			ADD=3'b101, // Adds the contents of the memory address or integer to the accumulator
			LDM=3'b110, // Load Multiple
			HLT=3'b111; // Halt

// state code			 
parameter Sidle=4'hf,
			 S0=4'd0,
			 S1=4'd1,
			 S2=4'd2,
			 S3=4'd3,
			 S4=4'd4,
			 S5=4'd5,
			 S6=4'd6,
			 S7=4'd7,
			 S8=4'd8,
			 S9=4'd9,
			 S10=4'd10,
			 S11=4'd11,
			 S12=4'd12;
			 
//PART A: D flip latch; State register
always @(posedge clk or negedge rst) 
begin
	if(!rst) state<=Sidle;
		//current_state <= Sidle;
	else state<=next_state;
		//current_state <= next_state;	
end

//PART B: Next-state combinational logic
always @*
begin
case(state)
S1:		begin
			if (ins==NOP) next_state=S0;
			else if (ins==HLT)  next_state=S2;
			else if (ins==PRE | ins==ADD) next_state=S9;
			else if (ins==LDM) next_state=S11;
			else next_state=S3;
		end

S4:		begin
			if (ins==LDA | ins==LDO) next_state=S5;
			//else if (ins==STO) next_state=S7; 
			else next_state=S7; // ---Note: there are only 3 long instrucions. So, all the cases included. if (counter_A==2*b11)
		end
Sidle:	next_state=S0;
S0:		next_state=S1;
S2:	    next_state=S2;
S3:		next_state=S4;
S5:		next_state=S6;
S6:		next_state=S0;
S7:		next_state=S8;
S8:		next_state=S0;
S9:		next_state=S10;
S10:	next_state=S0;
S11:	next_state=S12;
S12:	next_state=S0;
default: next_state=Sidle;
endcase
end

// another style
//PART C: Output combinational logic
always@*
begin 
case(state)
// --Note: for each statement, we concentrate on the current state, not next_state
// because it is combinational logic.
  Sidle: begin
		 write_r=1'b0;
		 read_r=1'b0;
		 PC_en=1'b0; 
		 ac_ena=1'b0;
		 ram_ena=1'b0;
		 rom_ena=1'b0;
		 ram_write=1'b0;
		 ram_read=1'b0;
		 rom_read=1'b0;
		 ad_sel=1'b0;
		 fetch=2'b00;
		 end
     S0: begin // load IR
		 write_r=0;
		 read_r=0;
		 PC_en=0;
 ac_ena=0;
		 ram_ena=0;
		 rom_ena=1;
		 ram_write=0;
		 ram_read=0;
		 rom_read=1;
		 ad_sel=0;
		 fetch=2'b01;
		 end
     S1: begin
		 write_r=0;
		 read_r=0;
		 PC_en=1; 
		 ac_ena=0;
		 ram_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_ena=1;
		 rom_read=1; 
		 ad_sel=0;
		 fetch=2'b00;
		 end
     S2: begin
		 write_r=0;
		 read_r=0;
		 PC_en=0;
		 ac_ena=0;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;
		 end
     S3: begin 
		 write_r=0;
		 read_r=0;
		 PC_en=0;
		 ac_ena=1; 
		 ram_ena=0;
		 rom_ena=1;
		 ram_write=0;
		 ram_read=0;
		 rom_read=1;
		 ad_sel=0;
	     fetch=2'b10; 
		 end
S4: begin
		 write_r=0;
		 read_r=0;
		 PC_en=1;
		 ac_ena=1;
		 ram_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_ena=1; 
		 rom_read=1;
		 ad_sel=0;
		 fetch=2'b10; 
		 end
     S5: begin
		 if (ins==LDO)
		 begin
		 write_r=1;
		 read_r=0;
		 PC_en=0;
		 ac_ena=1;
		 ram_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_ena=1;
		 rom_read=1;
		 ad_sel=1;
		 fetch=2'b01; 		 
		 end
		 else 
		 begin
		 write_r=1;
		 read_r=0;
		 PC_en=0;
		 ac_ena=1;
		 ram_ena=1;
	   	 ram_write=0;
		 ram_read=1;
		 rom_ena=0;
		 rom_read=0;
		 ad_sel=1;
		 fetch=2'b01;
		 end	 
		 end
     S6: begin 

	 write_r=1'b0;
		 read_r=1'b0;
		 PC_en=1'b0; //** not so sure, log: change 1 to 0
		 ac_ena=1'b0;
		 ram_ena=1'b0;
		 rom_ena=1'b0;
		 ram_write=1'b0;
		 ram_read=1'b0;
		 rom_read=1'b0;
		 ad_sel=1'b0;
		 fetch=2'b00;
	end

     S7: begin // STO, reg->ram. step1. read REG
		 write_r=0;
		 read_r=1;
		 PC_en=0;
		 ac_ena=0;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;
		 end
     S8: begin // STO, step2, write RAM
		 write_r=0;
		 read_r=1;
		 PC_en=0;
		 ac_ena=0;
		 rom_read=0;
		 rom_ena=0;

		 ram_ena=1;
		 ram_write=1;
		 ram_read=0;

		 ad_sel=1;
		 fetch=2'b00; //fetch=2'b10, ram_ena=1, ram_write=1, ad_sel=1;
		 end
     S9: begin 
		 if (ins==PRE) // REG->ACCUM
		 begin
		 write_r=0;
		 read_r=1;
		 PC_en=0;
		 ac_ena=1;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;
		 end
		 else 
		 begin 
		 write_r=0;
		 read_r=1;
		 PC_en=0;
		 ac_ena=1;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
 
		 fetch=2'b00;		 
		 end 
		 end
    S10: begin
		 write_r=0;
		 read_r=1;
		 PC_en=0;
		 ac_ena=0;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;
		 end
    S11: begin // LDM, step1, write reg
		 write_r=1;
		 read_r=0;
		 PC_en=0;
		 ac_ena=1;
		 ram_ena=0;
		
		 ram_write=0;
		 ram_read=0;
		 rom_ena=1;
		 rom_read=1;
		 ad_sel=0;
		 fetch=2'b00;
		 		
		 end
    S12: begin 
		 write_r=0;
		 read_r=0;
		 PC_en=0;
		 ac_ena=0;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;	 
		 end
default: begin
		 write_r=0;
		 read_r=0;
		 PC_en=0;
		 ac_ena=0;
		 ram_ena=0;
		 rom_ena=0;
		 ram_write=0;
		 ram_read=0;
		 rom_read=0;
		 ad_sel=0;
		 fetch=2'b00;		 
		 end
endcase
end
endmodule
