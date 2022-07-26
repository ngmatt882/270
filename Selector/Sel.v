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