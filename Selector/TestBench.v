`timescale 1 ns/1 ns

module TestBench();
	reg [16:0] SW;
	reg [3:3] KEY;
	wire [6:0] LEDR;
	wire[6:0] HEX0;
	
	Sel S[6:0](.EN(KEY[3:3]), .A(SW[6:0]), .B(SW[16:10]), .L(LEDR[6:0]), .H(HEX0[6:0]));
	
	initial begin
		KEY[3] = 0; SW[0] = 0; SW[10] = 0; #5;
		KEY[3] = 0; SW[0] = 0; SW[10] = 1; #5;
		KEY[3] = 0; SW[0] = 1; SW[10] = 0; #5;
		KEY[3] = 0; SW[0] = 1; SW[10] = 1; #5;
		KEY[3] = 1; SW[0] = 0; SW[10] = 0; #5;
		KEY[3] = 1; SW[0] = 0; SW[10] = 1; #5;
		KEY[3] = 1; SW[0] = 1; SW[10] = 0; #5;
		KEY[3] = 1; SW[0] = 1; SW[10] = 1; #5;
	end
endmodule