module Lookup(in, l, r);
    input [3:0] in;
    output [6:0] l, r;
    reg [6:0] Out[0:15];
    wire [3:0] conv;
    wire ovf;

    Abs AS(in, conv, ovf);
    initial
    begin
        Out[0] = 7'b1000000;
        Out[1] = 7'b1111001;
        Out[2] = 7'b0100100;
        Out[3] = 7'b0110000;
        Out[4] = 7'b0011001;
        Out[5] = 7'b0010010;
        Out[6] = 7'b0000010;
        Out[7] = 7'b1111000;
        Out[8] = 7'b0000000; // -8 will still show up as 8 when abs
        Out[9] = 7'b0010000; // There shouldn't be 9
    end
    
    assign r = Out[conv];
    assign l = in[3] ? 7'b0111111 : 7'b1111111;
endmodule