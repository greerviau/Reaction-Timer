module ReactionTimeDriver (
	input wire startB, stopB, clearB, clk,
	output wire led,
	output reg[6:0] testL,
	output reg[6:0] HEX0, HEX1, HEX2, HEX3
);

wire[2:0] currentState;
wire[13:0] reaction;
wire[3:0] num0, num1, num2, num3;
wire[6:0] HEX0REG, HEX1REG, HEX2REG, HEX3REG;

parameter   start = 3'b000,
			init = 3'b001,
			countdown = 3'b010,
			test = 3'b011,
			early = 3'b100,
			good = 3'b101,
			late = 3'b110;

ReactionTime(
	.startB(~startB),.stopB(~stopB),.clearB(~clearB),.clk(clk),.led(led),.state(currentState),.reaction(reaction)
);

binaryToBCD (
	.clk(clk),.bin(reaction),.bcd0(num0),.bcd1(num1),.bcd2(num2),.bcd3(num3)
);

BCDToSevenSeg h0(
	.code(num0),.hex(HEX0REG)
);

BCDToSevenSeg h1(
	.code(num1),.hex(HEX1REG)
);

BCDToSevenSeg h2(
	.code(num2),.hex(HEX2REG)
);

BCDToSevenSeg h3(
	.code(num3),.hex(HEX3REG)
);

always @* begin
	case(currentState)
		start: begin HEX0 <= 7'b1111111; HEX1 <= 7'b1111111; HEX2 <= 7'b1111111; HEX3 <= 7'b1111111; end
		init: begin HEX0 <= 7'b1001111; HEX1 <= 7'b0001001; HEX2 <= 7'b1111111; HEX3 <= 7'b1111111; end
		countdown: begin HEX0 <= 7'b1111111; HEX1 <= 7'b1111111; HEX2 <= 7'b1111111; HEX3 <= 7'b1111111; end
		test: begin HEX0 <= HEX0REG; HEX1 <= HEX1REG; HEX2 <= HEX2REG; HEX3 <= HEX3REG; end
		early: begin HEX0 <= HEX0REG; HEX1 <= HEX1REG; HEX2 <= HEX2REG; HEX3 <= HEX3REG; end
		good: begin HEX0 <= HEX0REG; HEX1 <= HEX1REG; HEX2 <= HEX2REG; HEX3 <= HEX3REG; end
		late: begin HEX0 <= HEX0REG; HEX1 <= HEX1REG; HEX2 <= HEX2REG; HEX3 <= HEX3REG; end
	endcase

end

endmodule 
