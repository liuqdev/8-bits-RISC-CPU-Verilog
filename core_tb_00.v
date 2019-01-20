`timescale 1ps / 1ps
module core_tb_00  ; 
 
  reg    rst   ; 
  reg    clk   ; 
  core  
   DUT  ( 
       .rst (rst ) ,
      .clk (clk ) ); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ps, End Time = 10 ns, Period = 100 ps
  initial
  begin
	  clk  = 1'b0  ;
	 # 150 ;
// 50 ps, single loop till start period.
   repeat(99)
   begin
	   clk  = 1'b1  ;
	  #50  clk  = 1'b0  ;
	  #50 ;
// 9950 ps, repeat pattern in loop.
   end
	  clk  = 1'b1  ;
	 # 50 ;
// dumped values till 10 ns
  end


// "Constant Pattern"
// Start Time = 0 ps, End Time = 10 ns, Period = 0 ps
  initial
  begin
	  rst  = 1'b0  ;
	 # 100;
	rst=1'b1;
	 # 9000 ;
// dumped values till 10 ns
  end

  initial
#20000 $stop;
endmodule
