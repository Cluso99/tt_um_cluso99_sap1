<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

Cluso's version of a SAP-1 style processor for implementation on a Tiny Tapeout run.

RAM memory/registers is 32 bytes (32 x 8-bits). 
Not all memory/registers (0..31) can be addressed by every instruction.
Some instructions use 3-bits for the instruction, and as they do not need an operand, the memory address 
is always set to '11111'. The top 3-bits plus the lower 5-bits of '11111' distinguish them from the other 3-bit instructions.
Some instructions use 3-bits for the instruction, leaving 5-bits for the memory address. These instructions 
can reference all of memory except memory address '11111' (i.e. registers 0..30). 
Some instructions use 4-bits for the instruction, leaving 4-bits for the memory address, These instructions 
can only reference the lower half of memory (i.e. registers 0..15).

The following instructions are planned.
// Instructions
// Note instr[4:0] = 5'b11111 (address = 11111) is reserved for special instructions not requiring an address operand
parameter INA  = 8'b000_11111;  // special case of LDA
parameter OUTA = 8'b001_11111;  // special case of STA
parameter SHL  = 8'b010_11111;  // special case of JMP
parameter SHR  = 8'b011_11111;  // special case of JNZ

// the following 3-bit instructions only reference 31 address registers 0..30 ('00000'..'11110'). 
// Instructions with address '11111' form special alternate instructions.
parameter LDA  = 3'b000;
parameter STA  = 3'b001;
parameter JMP  = 3'b010;
parameter JNZ  = 3'b011;

// the following 4-bit instructions only reference address registers 5'b0xxxx (16x lower 4-bit addresses)
parameter ADD  = 4'b1000;
parameter SUB  = 4'b1001;
// parameter xxx  = 4'b1010; 
// parameter xxx  = 4'b1011;
parameter AND  = 4'b1100; 
parameter OR   = 4'b1101;
parameter XOR  = 4'b1110;
// parameter xxx  = 4'b1111;


## How to test

Explain how to use your project (TBD)

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any (TBD)
