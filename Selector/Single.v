// Structural Implemention

module Single(a, l, h);
	input a;
	output l, h;

	and s1(l, a, a);
	not n1(na, a);
	and s2(h, na, na);
endmodule