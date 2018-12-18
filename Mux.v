module Mux(
	input wire din_0, din_1, sel, 
	output reg mux_out
	);


always @*
	if (sel == 1'b0)
		mux_out = din_0;
	else 
		mux_out = din_1;
		
endmodule
