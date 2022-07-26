// Top-Level Design Module

module Selector(KEY, SW, LEDR, HEX0);
	input [16:0] SW;
	input [3:3] KEY;
	output [6:0] LEDR;
	output [6:0] HEX0;

	Sel S[6:0](.EN(KEY[3:3]), .A(SW[6:0]), .B(SW[16:10]), .L(LEDR[6:0]), .H(HEX0[6:0]));
endmodule

/*
module Sel(EN, A, B, L, H);
	input EN;
	input A, B;
	output L, H;
	
	and S1(b1, EN, B);
	not S2(en1, EN);
	and S3(a1, en1, A);
	or S4(O, a1, b1);
	
	Single S5(O, L, H);
endmodule

module Single(a, l, h);
	input a;
	output l, h;

	and s1(l, a, a);
	not n1(na, a);
	and s2(h, na, na);
endmodule
*/