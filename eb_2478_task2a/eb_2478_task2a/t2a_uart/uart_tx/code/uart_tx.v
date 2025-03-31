// EcoMender Bot : Task 2A - UART Transmitter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to generate UART Tx data packet to transmit the messages based on the input data.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Transmitter

Input:  clk_3125 - 3125 KHz clock
        parity_type - even(0)/odd(1) parity type
        tx_start - signal to start the communication.
        data    - 8-bit data line to transmit

Output: tx      - UART Transmission Line
        tx_done - message transmitted flag
*/

// module declaration
module uart_tx(
    input clk_3125,
    input parity_type,tx_start,
    input [7:0] data,
    output reg tx, tx_done
);

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin
    tx = 1;
    tx_done = 0;
end

// Registers and Parameters
reg [3:0] baud_cnt = 4'd0;     // Counter for baud rate timing (Updated for new baud rate)
reg [7:0] tr_d;                // Register to hold transmitted data
reg start_b = 0;               // Start bit value (0 for UART)
reg stop_b = 1;                // Stop bit value (1 for UART)
reg parity_bit;                // Parity bit
reg [3:0] state = 4'b0000;     // State register for state machine control
parameter st_idle = 4'b1111,   // Idle state (waiting for tx_start)
          st_srt = 4'b0000,    // Start bit state
          td0 = 4'b0001,       // Transmit bit 0
          td1 = 4'b0010,       // Transmit bit 1
          td2 = 4'b0011,       // Transmit bit 2
          td3 = 4'b0100,       // Transmit bit 3
          td4 = 4'b0101,       // Transmit bit 4
          td5 = 4'b0110,       // Transmit bit 5
          td6 = 4'b0111,       // Transmit bit 6
          td7 = 4'b1000,       // Transmit bit 7
          parity_st = 4'b1001, // Parity bit state
          stop_st = 4'b1010;   // Stop bit state

// Parity bit calculation (even or odd parity)
always @(posedge clk_3125) begin
    // Determine parity based on parity_type input:
    // parity_type = 0 -> even parity, parity_type = 1 -> odd parity
    parity_bit = (parity_type == 0) ? (^data) : ~(^data);
end

// State machine for UART transmission
always @(posedge clk_3125) begin
    case (state)
        st_idle: begin
            // Wait for tx_start signal to begin transmission
            tx_done = 0;       // Ensure tx_done is low
            if (tx_start) begin
				 tx = start_b;  // Set tx to start bit immediately when tx_start is high
                state = st_srt; // Move to start bit state when tx_start is high
					 
            end
        end

        st_srt: begin
            // Start bit transmission
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = start_b;   // Transmit the start bit (0)
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td0;    // Move to transmit bit 0
            end
        end

        td0: begin
            // Transmit bit 0 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[7];   // Transmit LSB
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td1;    // Move to transmit bit 1
            end
        end

        td1: begin
            // Transmit bit 1 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[6];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td2;
            end
        end

        td2: begin
            // Transmit bit 2 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[5];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td3;
            end
        end

        td3: begin
            // Transmit bit 3 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[4];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td4;
            end
        end

        td4: begin
            // Transmit bit 4 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[3];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td5;
            end
        end

        td5: begin
            // Transmit bit 5 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[2];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td6;
            end
        end

        td6: begin
            // Transmit bit 6 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[1];
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = td7;
            end
        end

        td7: begin
            // Transmit bit 7 of the data
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = data[0];   // Transmit MSB
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = parity_st; // Move to parity bit state
            end
        end

        parity_st: begin
            // Transmit parity bit
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = parity_bit;  // Transmit the calculated parity bit
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 0;
                state = stop_st;  // Move to stop bit state
            end
        end

        stop_st: begin
            // Stop bit transmission
            if (baud_cnt < 13) begin  // Updated baud counter value for 230400 baud
                tx = stop_b;    // Transmit the stop bit (1)
                baud_cnt = baud_cnt + 1;
            end else begin
                baud_cnt = 1;
                tx_done = 1;    // Set tx_done high to indicate transmission complete
                state = st_idle; // Return to idle state
            end
        end

        default: begin
            // Default state
            state = st_idle;     // Go to idle state
        end
    endcase
end
//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule

