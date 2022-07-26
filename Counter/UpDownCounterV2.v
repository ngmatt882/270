module UpDownCounterV2(KEY, SW, LEDR);
    input [17:0] SW; // only using 17, 1, 0
    input [0:0] KEY;
    output reg [1:0] LEDR;
    
    parameter ZERO = 2'b00;
    parameter ONE = 2'b01;
    parameter TWO = 2'b10;
    parameter THREE = 2'b11;
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @ (posedge ~KEY[0])
    begin
        case(state)
        ZERO :  if(SW[17] == 1'b1)
                    next_state <= ZERO;
                else if (SW[1] == 1'b1 & SW[0] == 1'b1)
                    next_state <= ONE;
                else
                    next_state <= ZERO;
        ONE :   if(SW[17] == 1'b1)
                    next_state <= ZERO;
                else if (SW[1] == 1'b0)
                    next_state <= ONE;
                else if (SW[1] == 1'b1 & SW[0] == 1'b1)
                    next_state <= TWO;
                else if (SW[1] == 1'b1 & SW[0] == 1'b0)
                    next_state <= ZERO;
        TWO :   if(SW[17] == 1'b1)
                    next_state <= ZERO;
                else if (SW[1] == 1'b0)
                    next_state <= TWO;
                else if (SW[1] == 1'b1 & SW[0] == 1'b1)
                    next_state <= THREE;
                else if (SW[1] == 1'b1 & SW[0] == 1'b0)
                    next_state <= ONE;
        THREE : if(SW[17] == 1'b1)
                    next_state <= ZERO;
                else if (SW[1] == 1'b0)
                    next_state <= THREE;
                else if (SW[1] == 1'b1 & SW[0] == 1'b1)
                    next_state <= THREE;
                else if (SW[1] == 1'b1 & SW[0] == 1'b0)
                    next_state <= TWO;
        endcase
    end
    
    always @ *
    begin
        state = next_state;
        LEDR[0] = (state[1] & ~state[0]) | (state[1] & state[0]);
        LEDR[1] = (~state[1] & ~state[0]) | (state[1] & state[0]);
    end
    
endmodule