/*
# Team ID:          < eYRC##2478 >
# Theme:            < EcoMender Bot >
# Author List:      < AAKASHDEEP, SHIVAM KUMAR JHA, AARTI KUMARI, AARYAN KUMAR PANDEY >
# Filename:         < full_adder.v >
# File Description: < This Verilog module defines a 1-boit full adder that takes three input bits (a, b, c_in)
                      and produces two outputs bits: sum and c_out is determined by boolean_fn_1 and boolean_fn_2,
							 representing the sum and carry-out logic expressions, respectively.
							 e.g full_adder is used in calculators, ALU's, CPU etc >
# Global variables: < None >
*/

module sequence_detector (
    input clock,
	 // < clock >: < The input clock signal that drives the sequence detector's state transitions.>
    input [3:0] number,
	 // < [3:0] number >: < First 4-bit input to the sequence detector>
    output reg pattern 
	 //< pattern >: <"pattern" is an output port that is a reg type, used to store and drive the output value>
);


// State Machine Parameters
parameter ST_ONE = 0, ST_ZERO = 1, ST_NINE = 2, ST_FOUR = 3;
         // < ST_ONE >: < State representing detection of the first bit in the sequence. >
			// < ST_ZERO >: < State representing detection of the second bit (zero) in the sequence. >
			// < ST_NINE  >: < State representing detection of a specific intermediate sequence>
			// < ST_FOUR >: < Final state indicating successful detection of the target sequence. >


// defining 4-bit register
reg [1:0] state = ST_ONE;
     // < [1:0] state >: <A 2-bit register initialized to ST_ONE, used to track the current state in the state machine.>

initial begin 
     pattern = 0;
	 // < pattern >: < Initialize the output register "pattern" to 0 at the start of simulation. 
  
end




/*
Purpose: This block features sequential logic that updates the state and output pattern based
         on the "number" input and current state, synchronized with the "clock" signal's positive
			edge. State transitions are determined by the "number" value, triggering the output 
			"pattern" to set to 1 for specific state and input sequences.
---
< On each clock edge:
1. The pattern is reset to 0.
2. State transitions are handled by a case statement:
    - ST_ONE: Transition to ST_ZERO if number is 1; otherwise, remain in ST_ONE.
    - ST_ZERO: Transition to ST_NINE if number is 0; otherwise, reset to ST_ONE.
    - ST_NINE: Transition to ST_FOUR if number is 9; otherwise, reset to ST_ONE.
    - ST_FOUR: Transition to ST_ONE and set pattern to 1 if number is 4; otherwise, reset to ST_ONE.
    - default: Reset to ST_ONE.

The state machine detects the sequence (1, 0, 9, 4) and sets pattern to 1 upon completion.
Any deviation or unexpected input resets the machine to ST_ONE, with pattern remaining 0. >

*/
always @(posedge clock) begin
    pattern = 0;
    case (state)
        ST_ONE: begin
            if (number == 1) state = ST_ZERO;
            else state = ST_ONE;
        end
        ST_ZERO: begin
            if (number == 0) state = ST_NINE;
            else state = ST_ONE;
        end
        ST_NINE: begin
            if (number == 9) state = ST_FOUR;
            else state = ST_ONE;
        end
        ST_FOUR: begin
            if (number == 4) begin
                state = ST_ONE; pattern = 1;
            end
            else state = ST_ONE;
        end
        default: state = ST_ONE;
    endcase
end

endmodule