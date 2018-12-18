module Random (
    input wire clock, load, reset,
    output reg [15:0] rnd 
    );
reg [15:0] seed = 16'b11010011011100101;

wire serial_in;
wire [15:0] state_in;
wire [15:0] temprnd;
assign serial_in = (temprnd[5] ^ temprnd[4] ^ temprnd[3] ^ temprnd[0]);

Mux m0(.din_1(seed[0]), .din_0(serial_in), .sel(load), .mux_out(state_in[0]));
flipFlop ff0 (.clk(clock),.reset(reset), .d(state_in[0]), .q(temprnd[0]));

Mux m1(.din_1(seed[1]), .din_0(temprnd[0]), .sel(load), .mux_out(state_in[1]));
flipFlop ff1 (.clk(clock), .reset(reset), .d(state_in[1]), .q(temprnd[1]));

Mux m2(.din_1(seed[2]), .din_0(temprnd[1]), .sel(load), .mux_out(state_in[2]));
flipFlop ff2 (.clk(clock), .reset(reset), .d(state_in[2]), .q(temprnd[2]));

Mux m3(.din_1(seed[3]), .din_0(temprnd[2]),.sel(load), .mux_out(state_in[3]));
flipFlop ff3 (.clk(clock), .reset(reset), .d(state_in[3]), .q(temprnd[3]));

Mux m4(.din_1(seed[4]), .din_0(temprnd[3]), .sel(load), .mux_out(state_in[4]));
flipFlop ff4(.clk(clock), .reset(reset), .d(state_in[4]), .q(temprnd[4]));

Mux m5(.din_1(seed[5]), .din_0(temprnd[4]), .sel(load), .mux_out(state_in[5]));
flipFlop ff5(.clk(clock), .reset(reset), .d(state_in[5]), .q(temprnd[5]));

Mux m6(.din_1(seed[6]), .din_0(temprnd[5]), .sel(load), .mux_out(state_in[6]));
flipFlop ff6(.clk(clock), .reset(reset), .d(state_in[6]), .q(temprnd[6]));

Mux m7(.din_1(seed[7]), .din_0(temprnd[6]), .sel(load), .mux_out(state_in[7]));
flipFlop ff7(.clk(clock), .reset(reset), .d(state_in[7]), .q(temprnd[7]));

Mux m8(.din_1(seed[8]), .din_0(temprnd[7]), .sel(load), .mux_out(state_in[8]));
flipFlop ff8(.clk(clock), .reset(reset), .d(state_in[8]), .q(temprnd[8]));

Mux m9(.din_1(seed[9]), .din_0(temprnd[8]), .sel(load), .mux_out(state_in[9]));
flipFlop ff9(.clk(clock), .reset(reset), .d(state_in[9]), .q(temprnd[9]));

Mux m10(.din_1(seed[10]), .din_0(temprnd[9]), .sel(load), .mux_out(state_in[10]));
flipFlop ff10(.clk(clock), .reset(reset), .d(state_in[10]), .q(temprnd[10]));

Mux m11(.din_1(seed[11]), .din_0(temprnd[10]), .sel(load), .mux_out(state_in[11]));
flipFlop ff11(.clk(clock), .reset(reset), .d(state_in[11]), .q(temprnd[11]));

Mux m12(.din_1(seed[12]), .din_0(temprnd[11]), .sel(load), .mux_out(state_in[12]));
flipFlop ff12(.clk(clock), .reset(reset), .d(state_in[12]), .q(temprnd[12]));

Mux m13(.din_1(seed[13]), .din_0(temprnd[12]), .sel(load), .mux_out(state_in[13]));
flipFlop ff13(.clk(clock), .reset(reset), .d(state_in[13]), .q(temprnd[13]));

Mux m14(.din_1(seed[14]), .din_0(temprnd[13]), .sel(load), .mux_out(state_in[14]));
flipFlop ff14(.clk(clock), .reset(reset), .d(state_in[14]), .q(temprnd[14]));

Mux m15(.din_1(seed[15]), .din_0(temprnd[14]), .sel(load), .mux_out(state_in[15]));
flipFlop ff15(.clk(clock), .reset(reset), .d(state_in[15]), .q(temprnd[15]));


always @*
	begin
		rnd = temprnd;
		if(rnd < 2000)
			rnd = 2000;
		else if(rnd > 15000)
			rnd = 15000;
		else
			rnd = rnd;
		seed = temprnd;
	end

endmodule





