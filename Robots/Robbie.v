//top level design

module Robbie(SW, HEX1, HEX0);
	input [2:0] SW;
	output [6:0] HEX1, HEX0;
	parameter [6:0] F = 7'b0001110;
	parameter [6:0] S = 7'b0010010;
	
	rob r(.l(SW[2]), .f(SW[1]), .r(SW[0]), .lw(X), .rw(Y));
	
	select s1[6:0](.f(F), .s(S), .en(X), .w(HEX1[6:0]));
	select s2[6:0](.f(F), .s(S), .en(Y), .w(HEX0[6:0]));
endmodule

/*
//bottom level design

module rob(l, f, r, lw, rw);
	input l, f, r;
	output lw, rw;
	
	or g6(lw, f, r);
	or g7(rw, f, l);
endmodule



module select(f, s, en, w);
	input en;
	input f,s;
	output w;
	
	and g1(f1, en, f);
	not g2(en1, en);
	and g3(s1, en1, s);
	or g4(w, f1, s1);
	
endmodule
*/