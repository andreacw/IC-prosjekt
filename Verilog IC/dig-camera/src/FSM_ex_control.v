`timescale 1ms / 1us

module FSM_ex_control(input reg init, clk, reset, ovf5, output reg NRE_1, NRE_2, ADC, expose, erase, start); 
	parameter [1:0] idle = 2'b00;
	parameter [1:0] exposure = 2'b01;
	parameter [1:0] readout = 2'b10;
	
	reg [1:0] state, next_state;
	reg [4:0] read_counter;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= idle;	 
			read_counter <= 0;
		end
		else state <= next_state;
		
		if (state == readout) read_counter <= read_counter + 1; 
	end
	always @ (*)  begin
			case (state)
				idle : begin
					// Signaler som karakteristisk for state
					erase <= 1;
					expose <= 0;
					NRE_1 <= 1;
					NRE_2 <= 1;
					ADC <= 0;
					start <= 0;
					
					// Init styrer hopp
					if (init) begin
						next_state <= exposure;
						start <= 1;
						expose <= 0;
						erase <= 1;
					end
					else next_state <= state;
						
				end
				exposure : begin
					 erase <= 0;
					 start <= 0;
					 expose <= 1;
					if (ovf5) begin 
						next_state <= readout;
						expose <= 0;
						
					end
					else next_state <= exposure;
				end
				readout : begin
					 if (read_counter == 0) NRE_1 <= 0;
					 if (read_counter == 1) ADC <= 1;
					 if (read_counter == 2) ADC <= 0;
					 if (read_counter == 3) NRE_1 <= 1;
					 if (read_counter == 4) NRE_2 <= 0;
					 if (read_counter == 5) ADC <= 1;
					 if (read_counter == 6) ADC <= 0;
					 if (read_counter == 7) NRE_2 <= 1;
					 if (read_counter == 8) begin 
						 next_state <= idle;
						 erase <= 1;
					 end
				end	
			endcase
		 end
endmodule
				
						
					
					
			