module Lookup(in, l, r);
    input [3:0] in;     // 4 bit counter
    output [6:0] l, r;  // left and right display
    reg [6:0] Out[0:15];
    
    wire [3:0] d1, d0;

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
        Out[8] = 7'b0000000;
        Out[9] = 7'b0010000;
    end
    
    assign d1 = in / 'd10;
    assign d0 = in % 'd10;
    assign r = Out[d0];
    assign l = Out[d1];
endmodule