
// instr_mem.v - instruction memory
// The memory stores 32-bit (512 words) instructions and supports word-aligned memory access.

module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
    input       [ADDR_WIDTH-1:0] instr_addr, // Input: 32-bit address to the instruction memory
    output      [DATA_WIDTH-1:0] instr       // Output: 32-bit instruction retrieved from memory
);

//first decleare a 32 bit register then make an array of 512 such ram
reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];

initial begin

    //$readmemh("rv32i_book.hex", instr_ram);
	 
    // Uncomment the following line to load instructions from "rv32i_test.hex" instead.
    $readmemh("rv32i_test.hex", instr_ram);
end


assign instr = instr_ram[instr_addr[31:2]];// assigns the content at the instr_addr to output "instr" managing word allignement)

endmodule

