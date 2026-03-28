/*
 * Copyright (c) 2026 Cluso99
 * SPDX-License-Identifier: Apache-2.0
 */

module cpu(
    input wire clk, reset, prog, 
    output reg[7:0] output_register, 
    input wire[7:0] input_wires, 
    io wire [7:0] io_wires
);

// Intruction Defintion
// Note instr[4:0] = 5'b00000 (address = 00000) is reserved for special instructions not requiring an address operand
parameter INA  = 8'b000_00000;  // LDA 0 is special case 
parameter OUTA = 8'b001_00000;  // STA 0 is special case
parameter SHL  = 8'b010_00000;  //
parameter SHR  = 8'b011_00000;  //

// the following 3-bit instructions only reference address registers 5'b00001..5'b11111 (31x 5-bit addresses excluding 5'b00000)
parameter LDA  = 3'b000;
parameter STA  = 3'b001;
parameter JMP  = 3'b010;
parameter JNZ  = 3'b011;

// the following 4-bit instructions only reference address registers 5'b0xxxx (16x lower 4-bit addresses)
parameter ADD  = 4'b1000;
parameter SUB  = 4'b1001;
parameter xxx  = 4'b1010; 
parameter xxx  = 4'b1011;
parameter AND  = 4'b1100; 
parameter OR   = 4'b1101;
parameter XOR  = 4'b1110;
parameter xxx  = 4'b1111;


endmodule
