module binaryToBCD(
	input wire clk, start,
	input wire [19:0] bin,
	output wire[3:0] bcd3, bcd2, bcd1, bcd0
);


reg [4:0] i;
reg[15:0] bcd;

always @(posedge clk)
	begin
		bcd = 0;
		for(i = 0; i < 20; i = i+1)
			begin
				bcd = {bcd[14:0], bin[19-i]};
				
				if( i < 19 && bcd[3:0] > 4)
					bcd[3:0] = bcd[3:0] + 3;
				if(i < 19 && bcd[7:4] > 4)
					bcd[7:4] = bcd[7:4] + 3;
				if(i < 19 && bcd[11:8] > 4)
					bcd[11:8] = bcd[11:8] + 3;
				if(i < 19 && bcd[15:12] > 4)
					bcd[15:12] = bcd[15:12] + 3;
			end
	end
		
assign bcd0 = bcd[3:0];
assign bcd1 = bcd[7:4];
assign bcd2 = bcd[11:8];
assign bcd3 = bcd[15:12];
endmodule
