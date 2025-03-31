// EcoMender Bot : Task 2A - UART Receiver
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.

This file is used to receive UART Rx data packet from receiver line and then update the rx_msg and rx_complete data lines.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

/*
Module UART Receiver

Baudrate: 230400 

Input:  clk_3125 - 3125 KHz clock
        rx      - UART Receiver

Output: rx_msg - received input message of 8-bit width
        rx_parity - received parity bit
        rx_complete - successful uart packet processed signal
*/

// module declaration
module uart_rx(
    input clk_3125,
    input rx,
    output reg [7:0] rx_msg,
    output reg rx_parity,
    output reg rx_complete
    );

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

initial begin
    rx_msg = 0;
	  rx_parity = 0;
    rx_complete = 0;
end

// Register Definitions
reg [7:0] temp_data = 8'b00000000;
reg [3:0] bc = 4'd0;  // Baud counter for 13 cycles
reg temp_parity;
reg stop;
reg even_parity_check;

// State Definitions
parameter IDLE = 4'b1111;
parameter START_BIT = 4'b0000;
parameter BIT7 = 4'b0001;
parameter BIT6 = 4'b0010;
parameter BIT5 = 4'b0011;
parameter BIT4 = 4'b0100;
parameter BIT3 = 4'b0101;
parameter BIT2 = 4'b0110;
parameter BIT1 = 4'b0111;
parameter BIT0 = 4'b1000;
parameter PARITY_BIT = 4'b1001;
parameter STOP_BIT = 4'b1010;
parameter OUTPUT = 4'b1011;

// State register initialized to IDLE state
reg [3:0] state = IDLE;

// Sequential Logic Block: State machine to receive UART data
always @(posedge clk_3125) begin
    case (state)
        IDLE: begin
            rx_complete = 0;
           
                state = START_BIT;
            
        end

        START_BIT: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                bc = 0;
                state = BIT7;
            end
        end

        // Receiving each bit of the 8-bit message
        BIT7: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[7] = rx;
                bc = 0;
                state = BIT6;
            end
        end

        BIT6: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[6] = rx;
                bc = 0;
                state = BIT5;
            end
        end

        BIT5: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[5] = rx;
                bc = 0;
                state = BIT4;
            end
        end

        BIT4: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[4] = rx;
                bc = 0;
                state = BIT3;
            end
        end

        BIT3: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[3] = rx;
                bc = 0;
                state = BIT2;
            end
        end

        BIT2: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[2] = rx;
                bc = 0;
                state = BIT1;
            end
        end

        BIT1: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[1] = rx;
                bc = 0;
                state = BIT0;
            end
        end

        BIT0: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_data[0] = rx;
                bc = 0;
                state = PARITY_BIT;
            end
        end

        PARITY_BIT: begin
            if (bc < 13) begin
                bc = bc + 1;
            end else begin
                temp_parity = rx;
                bc = 0;
                state = STOP_BIT;
            end
        end

        STOP_BIT: begin
            if (bc < 13) begin
                stop = rx;
                bc = bc + 1;
            end else begin
                bc = 1;
                            // Check even parity
                even_parity_check = ^temp_data; // XOR all bits in temp_data
                if (even_parity_check != temp_parity) begin
                    rx_msg = 8'h3F; // Set to ASCII value '?' if parity error
                end else begin
                    rx_msg = temp_data;
                end
					 
            rx_parity = temp_parity;
            rx_complete = 1;
            state = IDLE;
            end
        end



        default: state = IDLE;
    endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////


endmodule

