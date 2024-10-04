/*
# Team ID:          < eYRC##2478 >
# Theme:            < EcoMender Bot >
# Author List:      < AAKASHDEEP, SHIVAM KUMAR JHA, AARTI KUMARI, AARYAN KUMAR PANDEY >
# Filename:         < and_gate_test_bench.v >
# File Description: < This Verilog testbench is designed to test the functionality of the and_gate module. 
                      It assigns all possible input combinations to the AND gate and monitors the output 
                      to verify its correctness. >
# Global variables: < None >
*/


module and_gate_test_bench;


reg a;
// < a >: < 1-bit register 'a' to provide the first input to the AND gate during testing >
reg b;
// < b >: < 1-bit register 'b' to provide the second input to the AND gate during testing >
wire out;
// < out >: < 1-bit wire 'out' to capture the output from the AND gate for validation >


and_gate uut (
    .a(a),   
	 //<a(a)>: < Connect the test input 'a' to the 'a' port of the DUT >
    .b(b),
	 //<b(b)>: < Connect the test input 'b' to the 'b' port of the DUT >
    .out(out)
	 //<out(out)>: < Connect the test output 'out' to the 'out' port of the DUT >
);

initial begin
    /*
    Purpose:
    ---
    Apply all possible combinations of inputs 'a' and 'b' to test the AND gate and verify its output.
    */

    a = 0; b = 0; #100; // < Apply inputs 'a' = 0 and 'b' = 0 and wait for 100 time units >
    a = 0; b = 1; #100; // < Apply inputs 'a' = 0 and 'b' = 1 and wait for 100 time units >
    a = 1; b = 0; #100; // < Apply inputs 'a' = 1 and 'b' = 0 and wait for 100 time units >
    a = 1; b = 1; #100; // < Apply inputs 'a' = 1 and 'b' = 1 and wait for 100 time units >
end 

endmodule