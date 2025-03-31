

//PWM Generator
//Inputs : clk_1MHz, pulse_width
//Output : clk_500Hz, pwm_signal

module pwm_generator(
    input clk_1MHz,
    input [3:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

initial begin
    clk_500Hz = 1; pwm_signal = 1;
end


// Counter for 1MHz to 500Hz clock division
    reg [9:0] counter_500Hz = -1;  // 10-bit counter (since 2^10 = 1024)
    reg [10:0] pwm_counter = 0; // Counter for PWM generation, assuming 16 steps for duty cycle control
	 // Generate 500Hz clock from 1MHz clock
    always @(posedge clk_1MHz) begin
        if (counter_500Hz == 999) begin
            clk_500Hz <= ~clk_500Hz;  // Toggle the 500Hz clock
            counter_500Hz <= 0;       // Reset the counter
        end else begin
            counter_500Hz <= counter_500Hz + 1;
        end
    end

    // PWM signal generation based on the pulse_width
    always @(posedge clk_1MHz) begin
        if (pwm_counter < (pulse_width*100)) begin
            pwm_signal <= 1; // PWM signal is high
        end else begin
            pwm_signal <= 0; // PWM signal is low
        end

        // Increment pwm_counter or reset when it reaches max (15 for 4-bit pulse width)
        if (pwm_counter == 1999) begin
            pwm_counter <= 0;
        end 
			else begin
            pwm_counter <= pwm_counter + 1;
        end
    end


endmodule
