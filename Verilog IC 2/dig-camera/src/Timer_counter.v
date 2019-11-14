`timescale 1 ms / 1 us
module Timer_counter (input wire clk, reset, start, input reg [4:0] ex_time, output reg ovf5);
	reg  [4:0] timer;  
	reg keep_counting;
	always @(posedge clk) begin
		if (reset) begin
			timer <= 0;
		
			ovf5 <= 0;

			keep_counting = 0;
		end
		
		else if (start) begin 
			timer <= ex_time - 1;
			keep_counting <= 1;
		end	   
		
		else if(timer != 0 && keep_counting) timer <= timer -1;
		
		else if (timer == 0 && keep_counting) begin 
			ovf5 <= 1;
			keep_counting <= 0;
						
		end
	end
endmodule					
		