
// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
	 input  [2:0] funct3,
	 input      Zero, ALUR31, lt,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc,
    output       RegWrite, Jump, jalr,
    output [1:0] ImmSrc,
    output [1:0] ALUOp
);

reg [10:0] controls;
reg TakeBranch;

always @(*) begin
TakeBranch = 0;
    casez (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump_jalr
        7'b0000011: controls = 11'b1_00_1_0_01_00_0_0; // lw
        7'b0100011: controls = 11'b0_01_1_1_00_00_0_0; // sw
        7'b0110011: controls = 11'b1_xx_0_0_00_10_0_0; // R–type
        7'b1100011: begin //branch
								controls = 11'b0_10_0_0_00_01_0_0;
									case(funct3)
										3'b000: TakeBranch = Zero;
										3'b001: TakeBranch = !Zero;
										3'b100: TakeBranch = ALUR31;//blt
										3'b101: TakeBranch = !ALUR31;//bge
										3'b110: TakeBranch = lt;//bltu
										3'b111: TakeBranch = !lt;//bltu
										
										
										//3'b110: TakeBranch = unsigned_less;    // bltu
										//3'b111: TakeBranch = !unsigned_less;   // bgeu
									endcase
							end
        7'b0010011: controls = 11'b1_00_1_0_00_10_0_0; // I–type ALU
        7'b1101111: controls = 11'b1_11_0_0_10_00_1_0; // jal
		  7'b1100111: controls = 11'b1_00_1_0_10_00_0_1;//jalr
		  7'b0?10111: controls = 11'b1_xx_x_0_11_xx_0_0; // lui or auipc
       // default:    controls = 11'bx_xx_x_x_xx_xx_x_0; // ???
    endcase
end

assign Branch = TakeBranch;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, ALUOp, Jump, jalr} = controls;

endmodule
