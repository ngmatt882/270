module Abs(a, r, ovf);
    input [3:0] a;
    output ovf;
    output [3:0] r;
    wire [3:0] inv;
    wire [3:0] b;
    
    assign inv[3] = 0;
    assign inv[2] = 0;
    assign inv[1] = 0;
    assign inv[0] = a[3];
    
    assign b = a[3] ? ~a : a;
    
    AddSub4Co FA(b, inv, 0, r, ovf);
    
endmodule