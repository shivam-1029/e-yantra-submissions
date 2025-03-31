

//Frequency Scaling
//Inputs : clk_50MHz
//Output : clk_1MHz


module frequency_scaler (
    input clk_50MHz,
    output reg clk_1MHz
);

initial begin
    clk_1MHz = 1;
end


// Counter to track the clock cycles
    reg [4:0] counter = -1; // 5-bit counter, since 2^5 = 32 > 24
	  always @(posedge clk_50MHz) begin
        if (counter == 24) begin
            clk_1MHz = ~clk_1MHz; // Toggle clk_1MHz
            counter = 0;          // Reset counter
        end else begin
            counter = counter + 1; // Increment counter
        end
    end


endmodule
