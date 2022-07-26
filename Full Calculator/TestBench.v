// Four-Function Calculator TestBench
`timescale 1ns/100ps
module TestBench();
	parameter WIDTH = 11;							// Data bit width

// Inputs and Outputs
	reg Clock;
	reg Clear;											// C button
	reg Equals;											// = button: displays result so far; does not repeat previous operation
	reg Add;												// + button
	reg Subtract;										// - button
	reg Multiply;										// x button (multiply)
	reg Divide;											// Divide button
	reg [WIDTH-1:0] NumberSM; 					// Must be entered in sign-magnitude on SW[W-1:0]
	wire signed [WIDTH-1:0] Result;
	wire Overflow;
	wire CantDisplay;
	wire [4:0] State;

	wire signed [WIDTH-1:0] NumberTC;
	SM2TC #(.width(WIDTH)) SM2TC1(NumberSM, NumberTC);
	FourFuncCalc #(.W(WIDTH)) FFC(Clock, Clear, Equals, Add, Subtract, Multiply, Divide, NumberSM, Result, Overflow, State);

	
// Define 10 ns Clock
	always #5 Clock = ~Clock;

	initial
	begin
		Clock = 0; Clear = 1;
		#20; Clear = 0;

	
//  1 + 3 - 4 = -1
      #10; NumberSM = 1;
		#20; Add = 1;
		#20; Add = 0;
		
		#10; Equals = 1; NumberSM = 3;
		#10; Equals = 0;

		#20; Subtract = 1;
		#20; Subtract = 0;
		#20; Equals = 1; NumberSM = 4; 
		#20; Equals = 0;

      #20; Clear = 1;
		#20; Clear = 0;
         
//  1023 + -1023 = 0
		#10; Equals = 1; NumberSM = 1023;
		#10; Equals = 0;
        
      #20; Add = 1;
      #20; Add = 0;
      #20; Equals = 1; NumberSM = 1023; NumberSM[10] = 1;
		#20; Equals = 0;
        
      #20; Clear = 1;
		#20; Clear = 0;
		
//  1023 + 10 = 1033 (Overflow)
      #10; Equals = 1; NumberSM = 1023;
		#10; Equals = 0;
        
      #20; Add = 1;
      #20; Add = 0;
      #20; Equals = 1; NumberSM = 10; 
		#20; Equals = 0;
		
		end

endmodule