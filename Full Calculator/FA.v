module FA(a,b,cin,cout,s);
    input a,b,cin;
    output cout,s;
    
    assign s = a ^ b ^ cin;
	assign cout = a & b | cin & (a ^ b);
endmodule