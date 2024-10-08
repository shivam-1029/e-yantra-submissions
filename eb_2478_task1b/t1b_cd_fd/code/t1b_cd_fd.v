// EcoMender Bot : Task 1B : Color Detection using State Machines
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will detect colors red, green, and blue using state machine and frequency detection.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Color Detection
//Inputs : clk_1MHz, cs_out
//Output : filter, color

// Module Declaration
module t1b_cd_fd (
    input  clk_1MHz, cs_out,
    output reg [1:0] filter, color
);

// red   -> color = 1;
// green -> color = 2;
// blue  -> color = 3;

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////


// Color codesi
/*parameter RED   = 2'b01;  // Color code for red
parameter GREEN = 2'b10;  // Color code for green
parameter BLUE  = 2'b11;  // Color code for blue*/

// Filter codes (based on S2 and S3)
parameter F_3   = 2'b11;  // Filter 3 green
parameter F_0   = 2'b00;  // Filter 0 red
parameter F_1   = 2'b01;  // Filter 1 blue
parameter F_2   = 2'b10;  // Filter 2 clear

// Timers for switching filters
reg [8:0] timer_500us;  // Timer for 500 µs

// FSM state register
reg [1:0] state;

reg [8:0] red_freq, green_freq, blue_freq;  // Frequency storage for red, green, blue filters counted values
reg [8:0] pulse_counter;    // Counter to count pulses from the cs_out signal

initial begin
    // Initial states
    filter = F_3;      // Start with filter 3
    color = 0;     // No color detected initially
    timer_500us = 0;  // Initialize 500 µs timer
    state = F_3;       // Set initial state to filter 3
	 pulse_counter = 0;
	 red_freq = 0; green_freq = 0; blue_freq = 0;
end

// Always block for FSM and timing logic
always @(posedge clk_1MHz) begin
// Count pulses from cs_out (color sensor frequency)
    if (cs_out == 1) begin
        pulse_counter <= pulse_counter + 1;
    end

	// Check the current state
    if ((state == F_2 && timer_500us == 1) || (state != 2 && timer_500us == 500)) begin
	 
                case (state)
                    F_3: begin
						  // Green Filter: Store frequency and move to Red Filter (0)
								green_freq <= pulse_counter;
								pulse_counter <= 0;// Reset the counter for the next filter
								
                        filter <= F_0;   // Apply filter 0
                        state <= F_0;    // Move to next filter (0)
							end
						  
						  
                    F_0: begin
						  // Red Filter: Store frequency and move to Blue Filter (1)
							red_freq <= pulse_counter;	
							pulse_counter <= 0;// Reset the counter for the next filter
							
                        filter <= F_1;   // Apply filter 1
                        state <= F_1;    // Move to next filter (1)
                    end
						  
						  
                    F_1: begin
						  // Blue Filter: Store frequency, perform color detection, and move to Clear Filter (2)
							blue_freq <= pulse_counter;
							pulse_counter <= 0;// Reset the counter for the next filter
							
							// Perform color detection after Blue Filter
               if (red_freq >= green_freq && red_freq >= blue_freq && (red_freq > green_freq || red_freq > blue_freq)) begin
        color <= 1;  // Red
    end else if (green_freq >= red_freq && green_freq >= blue_freq && (green_freq > red_freq || green_freq > blue_freq)) begin
        color <= 2;  // Green
    end else if (blue_freq >= red_freq && blue_freq >= green_freq && (blue_freq > red_freq || blue_freq > green_freq)) begin
        color <= 3;  // Blue
    end else begin
        color <= 0;  // Default/Unknown (including the case where all frequencies are equal)
    end
					 
                        filter <= F_2;   // Apply filter 2
                        state <= F_2;    // Move to next filter (2)	
                    end
						  
						  
						  F_2: begin
						      
								filter <= F_3;   // Apply filter 3
								state <= F_3;
							end
                endcase
					 timer_500us <= 1; // Reset timer for the next filter
					end 
					else begin
					timer_500us <= timer_500us + 1;
					end
					 
            end



//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
