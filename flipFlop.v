module flipFlop(
	input wire clk, reset, d,
	output reg q
	);
wire enable = 1'b1;
reg r_reg, r_next, qt;	
always @(posedge clk, posedge reset)
	begin
		if(reset)
			r_reg <= 1'b0;
		else if(enable);
			r_reg <= r_next;
		end
always @*
	begin
		if(enable)
			r_next <= d;
		else
			r_next <= r_reg;
	end
always @*
	qt = r_reg;

endmodule
