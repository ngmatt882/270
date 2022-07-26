module Renee(SW, KEY, HEX1, HEX0);
	input [6:0] SW;
	input [3:0] KEY;
	output [6:0] HEX1, HEX0;
	parameter [6:0] F = 7'b0001110;
	parameter [6:0] S = 7'b0010010;
	parameter [6:0] r = 7'b0101111;
	wire X1, Y1, O2, O3;

	sensor s1(.a(SW[6:4]), .b(SW[2:0]), .l(L), .r(R), .s(ST));
	rob r1(.l(L), .s(ST), .r(R), .lw(LW), .rw(RW));

	stop s2(.a(KEY[3]), .b(KEY[2]), .c(KEY[1]), .d(KEY[0]), .x(X1), .y(Y1));
	lforward l1(.a(KEY[3]), .b(KEY[2]), .c(KEY[1]), .d(KEY[0]), .o(O2));
	rforward r2(.a(KEY[3]), .b(KEY[2]), .c(KEY[1]), .d(KEY[0]), .o(O3));
	
	assign s = (KEY[0] && KEY[1]) && (KEY[2] && KEY[3]);
	
	assign HEX1 = s ? (LW ? F : S) : (X1 ? S : (O2 ? F : r));
	assign HEX0 = s ? (RW ? F : S) : (Y1 ? S : (O3 ? F : r));
endmodule

/*
module sensor(a,b,l,r,s);
	input [2:0] a, b;
	output l,r,s;
	
	assign left = (a[2] && ~b[2]) ? 1 : ((~a[2] && b[2]) ? 0 : ((a[1] && ~b[1]) ? 1 : ((~a[1] && b[1]) ? 0 : ((a[0] && ~b[0]) ? 1 : 0))));
	assign same = (a[2] ~^ b[2]) && (a[1] ~^ b[1]) && (a[0] ~^ b[0]);
	
	assign l = left || same;
	assign r = ~left || same;
	assign s = ~(a[2] || b[2]) && ~(a[1] || b[1]) && ~(a[0] || b[0]);
endmodule


module rob(l, s, r, lw, rw);
	input l, s, r;
	output lw, rw;
	
	assign lw = r && ~s;
	assign rw = l && ~s;
endmodule


// bottom level designs

module stop(a,b,c,d,x,y);
	input a, b, c, d;
	output x,y;
	
	assign right = ~a && b;
	assign left = a && ~b;
	
	// if both are on stop
	assign x = (~a && ~b) || (~c && ~d) || left;
	assign y = (~a && ~b) || (~c && ~d) || right;

endmodule


module lforward(a,b,c,d,o);
	input a,b,c,d;
	output o;
	
	assign o = (~d && b) && c;
endmodule


module rforward(a,b,c,d,o);
	input a,b,c,d;
	output o;
	
	assign o = (~d && a) && c;
endmodule
*/