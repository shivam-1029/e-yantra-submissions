/*
# Team ID:          < eYRC##2478 >
# Theme:            < EcoMender Bot >
# Author List:      < AAKASHDEEP, SHIVAM KUMAR JHA, AARTI KUMARI, AARYAN KUMAR PANDEY >
# Filename:         < tb_ripple_carry_adder.v >
# File Description: < This Verilog testbench module is designed to test the ripple carry adder module. 
                      It applies various input combinations to the ripple carry adder and observes the 
                      resulting outputs to verify its functionality. >
# Global variables: < None >
*/

module tb_ripple_carry_adder; 

reg [1:0] a; 
// <reg [1:0] a>:< 2-bit register 'a' to drive the first input vector to the ripple carry adder>
reg [1:0] b;
// <reg [1:0] b>:<  2-bit register 'b' to drive the second input vector to the ripple carry adder>
reg cin;
// <reg cin>:<  1-bit register 'cin' to drive the carry-in input to the ripple carry adder>
wire [1:0] sum;
 // <wire [1:0] sum>:<2-bit wire 'sum' to capture the sum output from the ripple carry adder>
wire c_out;
 // <reg cin> :< 1-bit wire 'c_out' to capture the carry-out output from the ripple carry adder>

// Instantiate the Device Under Test (DUT)
// 'uut' stands for Unit Under Test
ripple_carry_adder uut (
    .a(a),    // Connect input 'a' to the 'a' port of the DUT
    .b(b),    // Connect input 'b' to the 'b' port of the DUT
    .cin(cin), // Connect carry-in 'cin' to the 'cin' port of the DUT
    .sum(sum), // Connect output 'sum' to the 'sum' port of the DUT
    .c_out(c_out) // Connect output carry-out 'c_out' to the 'c_out' port of the DUT
);

initial begin 
    a = 2'b01; 
    b = 2'b11; 
    cin = 1'b1; 
    #100; // Wait for 100 time units before changing inputs

    a = 2'b11; 
    b = 2'b11; 
    cin = 1'b1;
    #100; // Wait for 100 time units before changing inputs

    a = 2'b10; 
    b = 2'b01; 
    cin = 1'b0; 
    #100; // Wait for 100 time units before changing inputs

    a = 2'b00; 
    b = 2'b11; 
    cin = 1'b0; 
    #100; // Wait for 100 time units before ending the simulation

end 

endmodule 

