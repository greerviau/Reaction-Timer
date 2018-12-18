module ReactionTime (
	input startB, stopB, clearB, clk,
	output reg led,
	output reg[6:0] testL,
	output reg[2:0] state, 
	output reg[13:0] reaction
);

parameter   start = 3'b000,
			init = 3'b001,
			countdown = 3'b010,
			test = 3'b011,
			early = 3'b100,
			good = 3'b101,
			late = 3'b110;
			
wire slowclk;
reg enableCD, enableCU;
reg [13:0] limit;
wire [13:0] random, counterUp, counterDown;
wire CDTick, CUTick;

SlowClock(
	.clk(clk),.reset(clear),.clk_1Hz(slowclk)
);

Random(
	.clock(clk),.load(startB),.reset(clearB),.rnd(random)
);

Counting countingdown (
	.clk(slowclk),.enable(enableCD),.done(CDTick),.limit(limit),.outputNum(counterDown)
);

Counting countingup (
	.clk(slowclk),.enable(enableCU),.done(CUTick),.limit(1000),.outputNum(counterUp)
);

always @(posedge clk) begin
	case(state)
		start: begin
			if(clearB) begin
				state <= init;
				limit <= random;
			end
		end
		init: begin
			if(startB) begin
				state <= countdown;
				enableCD <= 1;
				enableCU <= 0;
			end
			else if(clearB) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
			end
		end	
		countdown: begin
			if(CDTick) begin
				state <= test;
				led <= 1;
				enableCD <= 0;
				enableCU <= 1;
			end
			else if(stopB) begin
				state <= early;
				reaction <= 9999;
				enableCD <= 0;
				enableCU <= 0;
			end
			else if(clearB) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
			end
		end
		test: begin
			reaction <= counterUp;
			if(CUTick) begin
				state <= late;
				led <= 0;
				reaction <= 1000;
				enableCD <= 0;
				enableCU <= 0;
			end
			else if(stopB) begin
				state <= good;
				led <= 0;
				reaction <= counterUp;
				enableCD <= 0;
				enableCU <= 0;
			end
			else if(clearB) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
			end
		end
		default: begin
			if(clearB) begin
				state <= init;
				limit <= random;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
			end
		end
	endcase
end

endmodule
