`timescale 1 ms / 1 us

//module FSM_ex_control(input logic init, clk, reset, ovf5, start, output NRE_1, NRE_2, ADC, expose, erease); 
//	reg [3:0] 
//	always@(posedge Clk)
//		if (Reset) state <= s0;
//		else state <= next_state;
	

module CTRL_ex_time (input wire exp_inc, exp_dec, clk, reset, output reg [4:0] ex_time);
	always @(posedge clk) begin
		if (reset) ex_time <= 15;
		if (exp_inc & ex_time<30)
		 ex_time <= ex_time+1;
		else if (exp_dec & ex_time>2) ex_time <= ex_time-1;
	end
endmodule					
		
		