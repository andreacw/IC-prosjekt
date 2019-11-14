`timescale 1 ms / 1 us
module TestBench ();
	reg clk , reset ;
	reg init , exp_inc, exp_dec;
	reg NRE_1 , NRE_2 , ADC , expose , erase ;
	// define the clock
	always begin
		clk = 1; #0.5; clk = 0; #0.5;
	end

	// Start pulses
	initial begin
		
		init = 0; reset = 1; exp_inc = 0; exp_dec = 0; clk = 1;  #2;
		reset = 0; #1; 
		init = 1; #1;
		init = 0; #50;
		//reset = 1; #1;
		//reset = 0; #100;			
	$finish;
	end
	// Test camera with pulses
	RE_control dut(init , exp_inc , exp_dec, clk , reset , NRE_1 , NRE_2 , ADC , expose , erase );
endmodule