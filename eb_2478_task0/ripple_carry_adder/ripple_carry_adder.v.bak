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


module full_adder (
    input a, b, c_in, // Define input ports a, b, and c_in
    
    // < a >: < First 1-bit input to the full adder.>
    // < b >: < Second 1-bit input to the full adder.>
    // < c_in >: < Carry input from the previous stage or lower bit column.>

    output sum, c_out // Define output ports sum and c_out
    
    // < sum >: < The 1-bit output representing the sum of a, b, and c_in.>
    // < c_out >: < The 1-bit carry output to the next stage or higher bit column.>

);
assign sum = a ^ b ^ c_in; // XOR operation for sum
assign c_out = ((a & b) | (c_in & (a ^ b))); // Logic for carry-out


endmodule