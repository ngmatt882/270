
module UpDownCounterV1(KEY, SW, LEDR);
    input [17:0] SW; // only using 17, 1, 0
    input [0:0] KEY;
    output reg [1:0] LEDR;
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @ (posedge ~KEY[0])
    begin
        next_state[1] <= SW[17] ? 0 : ((~state[1] & state[0] & SW[1] & SW[0]) | (state[1] & ~state[0] & ~SW[1]) 
                                    | (state[1] & ~state[0] & SW[1] & SW[0]) | (state[1] & state[0]));
        next_state[0] <= SW[17] ? 0 : ((~state[1] & ~state[0] & SW[1] & SW[0]) | (~state[1] & state[0] & ~SW[1]) 
                                    | (state[1] & ~state[0] & SW[1] & SW[0]) | (state[1] & ~state[0] & SW[1] & ~SW[0])
                                    | (state[1] & state[0] & ~SW[1]) | (state[1] & state[0] & SW[1] & SW[0]));
    end
    
    always @ *
    begin
        state = next_state;
        LEDR[0] = (state[1] & ~state[0]) | (state[1] & state[0]);
        LEDR[1] = (~state[1] & ~state[0]) | (state[1] & state[0]);
    end
    
endmodule 