module TrafficLightController(KEY, SW, HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6, HEX7);
    input [0:0] KEY;
    input [17:0] SW;
    //traffic lights
    output reg [6:0] HEX0;  // WTL
    output reg [6:0] HEX1;  // ELTL
    output reg [6:0] HEX2;  // NLTL
    output reg [6:0] HEX3;  // ETL
    //timer
    output [6:0] HEX4;
    output [6:0] HEX5;
    
    output [6:0] HEX6;
    output [6:0] HEX7;
    //traffic light displays
    parameter RED = 7'b0101111;
    parameter GREEN = 7'b0010000;
    parameter YELLOW = 7'b0010001;
    //states
    parameter ZERO = 4'b0000;
    parameter ONE = 4'b0001;
    parameter TWO = 4'b0010;
    parameter THREE = 4'b0011;
    parameter FOUR = 4'b0100;
    parameter FIVE = 4'b0101;
    parameter SIX = 4'b0110;
    parameter SEVEN = 4'b0111;
    parameter EIGHT = 4'b1000;
    parameter NINE = 4'b1001;
    
    reg [3:0] counter;
    reg [3:0] state;
    reg [3:0] next_state;
    
    // next state based on sensors
    always @ *
    begin
        case(state)
        ONE :   if(SW[17] == 1)
                    next_state <= ONE;
                else if(counter < 3)
                    next_state <= ONE;
                else if(SW[3:0] == 0)
                    next_state <= FOUR;
                else if(SW[2] == 1)
                    next_state <= FOUR;
                else if(SW[1] == 1)
                    next_state <= EIGHT;
                else if(SW[2:1] == 0)
                    next_state <= ONE;
                //else if(counter == 10)
                    //next_state <= FOUR;
        TWO :   if(SW[17] == 1)
                    next_state <= ONE;
                else if(counter < 3)
                    next_state <= TWO;
                else if(SW[3:0] == 0)
                    next_state <= SIX;
                else if(SW[1] == 1)
                    next_state <= SIX;
                else if(SW[0] == 1)
                    next_state <= FIVE;
                else if(SW[1:0] == 2'b00)
                    next_state <= TWO;
                //else if(counter == 10)
                    //next_state <= SIX;
			// bugged
        THREE : if(SW[17] == 1)
                    next_state <= ONE;
                else if(counter < 3)
                    next_state <= THREE;
                else if(SW[3:0] == 0)
                    next_state <= NINE;
                else if(SW[0] == 1 | (SW[3] == 1))
                    next_state <= NINE;
                else if(SW[2] == 1)
                    next_state <= SEVEN; 
                else if(SW[3:0] == 4'b0010)
                    next_state <= THREE;
                //else if(counter == 10)
                    //next_state <= NINE;
        FOUR :  if(SW[17] == 1)
                    next_state <= ONE;
                else
                    next_state <= TWO;
        FIVE :  if(SW[17] == 1)
                    next_state <= ONE;
                else
                    next_state <= ONE;
        SIX :   if(SW[17] == 1)
                    next_state <= ONE;
                else
                    next_state <= THREE;
        SEVEN : if(SW[17] == 1)
                    next_state <= ONE;
                else    
                    next_state <= TWO;
        EIGHT : if(SW[17] == 1)
                    next_state <= ONE;
                else
                    next_state <= THREE;
        NINE :  if(SW[17] == 1)
                    next_state <= ONE;
                else
                    next_state <= ONE;
        endcase
    end
    
    //state and counter
    always @ (posedge ~KEY[0])
    begin
        state = next_state;
        if(SW[17] == 1)
            counter = 0;
        else if(state == 1 ||  state == 2 || state == 3)
            counter = counter + 1;
        else
            counter = 0;
    end
    
    // output
    always @ *
    begin
        case(state)
        ONE :   begin
            HEX0 = GREEN;
            HEX1 = RED;
            HEX2 = RED;
            HEX3 = GREEN;
                end
        TWO :   begin
            HEX0 = RED;
            HEX1 = RED;
            HEX2 = GREEN;
            HEX3 = GREEN;
                end
        THREE : begin
            HEX0 = RED;
            HEX1 = GREEN;
            HEX2 = RED;
            HEX3 = RED;
                end
        FOUR :   begin
            HEX0 = YELLOW;
            HEX1 = RED;
            HEX2 = RED;
            HEX3 = GREEN;
                end
        FIVE :   begin
            HEX0 = RED;
            HEX1 = RED;
            HEX2 = YELLOW;
            HEX3 = GREEN;
                end
        SIX :   begin
            HEX0 = RED;
            HEX1 = RED;
            HEX2 = YELLOW;
            HEX3 = YELLOW;
                end
        SEVEN :   begin
            HEX0 = RED;
            HEX1 = YELLOW;
            HEX2 = RED;
            HEX3 = RED;
                end
        EIGHT :   begin
            HEX0 = YELLOW;
            HEX1 = RED;
            HEX2 = RED;
            HEX3 = YELLOW;
                end
        NINE :   begin
            HEX0 = RED;
            HEX1 = YELLOW;
            HEX2 = RED;
            HEX3 = RED;
                end
        endcase
        
    end
    
    Lookup LU(counter [3:0], HEX7, HEX6);
    
endmodule