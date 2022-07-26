module Calculator(KEY, SW, HEX0, HEX2, HEX3, HEX4, HEX5, HEX6,HEX7);
    input [2:0] KEY;
    input [7:0] SW;
    output [6:0] HEX0, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
    wire [3:0] a, b;
    wire [3:0] result, sumR, absR;
    wire resultovf, absovf;
    
    //swap order
    assign b = KEY[2] ? SW [7:4] : SW [3:0];
    assign a = KEY[2] ? SW [3:0] : SW [7:4];
    AddSub4Co AS(a,b,KEY[0], sumR, resultovf);
    
    // Absolute value
    Abs AB(b, absR, absovf);

    //old implementation showed error for either case
    //assign totalovf = absovf | resultovf;
    //assign HEX0 = totalovf ? 7'b0000110 : 7'b1111111;
    
    // show if overflowed
    assign HEX0 = KEY[1] ? (absovf ? 7'b0000110 : 7'b1111111) : (resultovf ? 7'b0000110 : 7'b1111111);
    // pick which result
    assign result = KEY[1] ? absR : sumR;
    
    Lookup LU1(result, HEX3, HEX2);
    Lookup LU2(SW [7:4], HEX7, HEX6);
    Lookup LU3(SW [3:0], HEX5, HEX4);
endmodule