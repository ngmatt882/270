module Calc(CLOCK_50, KEY, SW, LEDG, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
    input CLOCK_50;
    input [3:0] KEY;
    input [17:0] SW;
    output [8:8] LEDG;
    output [6:0] HEX0;
    output [6:0] HEX1;
    output [6:0] HEX2;
    output [6:0] HEX3;
    output [6:0] HEX4;
    output [6:0] HEX5;
    output [6:0] HEX6;
    output [6:0] HEX7;
    
    wire signed [W-1:0] Result;
    wire Overflow;
    wire [4:0] ControlState;
    
    localparam W = 11;
    localparam CLOCK_DIVIDER_SIZE = 36;
    localparam CLOCK_TAP = 0;
    
    wire add = ~KEY[3] & ~SW[17];
    wire sub = ~KEY[2] & ~SW[17];
    wire mult = ~KEY[1] & ~SW[17];
    wire dvd = ~KEY[0] & ~SW[17];
    wire eq = ~KEY[3] & SW[17];
    wire clr = ~KEY[0] & SW[17];
    
    wire [CLOCK_DIVIDER_SIZE:0] CLOCKS; 
    Clock_Div # (.SIZE(CLOCK_DIVIDER_SIZE)) CD(CLOCK_50, CLOCKS);
    FourFuncCalc #(.W(W)) FFC (CLOCKS[26], clr, eq, add, sub, mult, dvd, SW[10:0], Result, Overflow, ControlState);
    
    
    assign LEDG[8:8] = Overflow;
    Binary_to_7SEG #(.W(W)) B7S1(.N(SW[10:0]), .Encoding(0), .Sign(HEX7[6:0]), .D2(HEX6[6:0]), .D1(HEX5[6:0]), .D0(HEX4[6:0]));
    Binary_to_7SEG #(.W(W)) B7S2(.N(Result), .Encoding(1), .Sign(HEX3[6:0]), .D2(HEX2[6:0]), .D1(HEX1[6:0]), .D0(HEX0[6:0]));
    
endmodule