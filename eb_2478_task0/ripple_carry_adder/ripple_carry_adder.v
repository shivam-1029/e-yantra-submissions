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

module ripple_carry_adder (
    input [1:0] a, b,
    // < a >: < First 2-bit input to the full adder.>
    // < b >: < Second 2-bit input to the full adder.>
	 
	 
    input cin,
     // < c_in >: < Carry input from the previous stage or lower bit column.>
 
	 
    output [1:0] sum,
    output c_out // Define all output ports
	  // < sum >: < The 2-bit output representing the sum of a, b, and c_in.>
    // < c_out >: < The 1-bit carry outputs the carry bit.>
);
wire c1; // Define intermediate carry as c1

full_adder FA0 (a[0], b[0], cin, sum[0], c1); // instantiate full_adder (FA0)
full_adder FA1 (a[1], b[1], c1, sum[1], c_out); // instantiate full_adder (FA1)

endmodule