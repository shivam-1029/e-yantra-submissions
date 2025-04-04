/*
# Team ID:          < eYRC##2478 >
# Theme:            < EcoMender Bot >
# Author List:      < AAKASHDEEP, SHIVAM KUMAR JHA, AARTI KUMARI, AARYAN KUMAR PANDEY >
# Filename:         < and_gate.v >
# File Description: < This Verilog module defines a simple 2-input AND gate.
                      The module takes two 1-bit inputs (a and b) and produces 
                      a 1-bit output (out) based on the AND logic operation. >
# Global variables: < None >
*/

module and_gate (
    input a,
 // < a >: < First 1-bit input to the AND gate >
    input b,
 // < b >: < Second 1-bit input to the AND gate >
    output out
 // < out >: < 1-bit output representing the result of the AND operation on inputs a and b >
);

/*
Purpose:
---
This section of code implements the AND gate logic by assigning the output 'out' 
to be the result of the bitwise AND operation on inputs 'a' and 'b'.
*/
assign out = a & b; // < Perform bitwise AND operation on inputs 'a' and 'b' and assign the result to 'out' >

endmodule // End of and_gate module