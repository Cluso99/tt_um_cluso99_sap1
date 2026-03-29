/*
 * Copyright (c) 2026 Cluso99
 * SPDX-License-Identifier: Apache-2.0
 */

module cpu(
    input wire ena, clk, reset, 
    output reg[7:0] output_register, 
    input wire[7:0] input_wires, 
    io wire [7:0] io_wires
);

// Instructions
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
// parameter xxx  = 4'b1010; 
// parameter xxx  = 4'b1011;
parameter AND  = 4'b1100; 
parameter OR   = 4'b1101;
parameter XOR  = 4'b1110;
// parameter xxx  = 4'b1111;


//Control Signals
reg pc_in;
reg pc_out;
reg pc_inc;
reg mar_in;
reg ram_in;
reg ram_out;
reg ir_in;
reg ir_out; 
reg a_in;
reg a_out;
reg b_in;
reg b_out;
reg alu_op;
reg alu_out;
//reg output_in;    // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//reg input_xx;     // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



// Registers
reg[2:0] state;
reg[4:0] pc;
reg[4:0] mar;
reg[7:0] ram[31:0];
reg[7:0] ir;
reg[7:0] a_reg;
reg[7:0] b_reg;
reg z_flag;
reg c_flag;

// Bus
wire[7:0] bus;
assign bus =
    pc_out  ? {3'b000, pc} :
    ram_out ? ram[mar] :
    ir_out  ? ir :
    a_out   ? a_reg :
    b_out   ? b_reg :
    alu_out ? alu[7:0] :
    8'b0;

always @(posedge clk) begin

// Instruction State Counter
    if (reset) begin
        state <= 3'd0;
    end else if (state > 3'd6) begin
        state <= 3'd1;
    end else begin
        state <= state + 3'd1;
    end

// Program Counter
    if (reset) begin
        pc <= 5'b00001;                // pc starts at 00001 as addr 0 is special case
    end else if (pc_inc) begin
        pc <= pc + 1'b1;
    end else if (pc_in) begin
        pc <= {bus[4:0]};
    end

// Memory Address Register
    if (reset) begin
        mar <= 5'b0;
    end else if (mar_in) begin
        mar <= bus[4:0];
    end

// RAM
    if (prog == 1'b1) begin
        ram[addr] <= prog_input;        // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    end else if (mar_in) begin
        ram[mar] <= bus;
    end

// Instruction Register
    if (reset) begin
        ir <= 8'b0;
    end else if (ir_in) begin
        ir <= bus;
    end

// Output Register
    if (reset) begin
        out_reg <= 8'b0;
    end else if (output_in) begin
        out_reg <= bus;
    end

// A Register (accumulator)
    if (reset) begin
        a_reg <= 8'b0;
    end else if (a_in) begin
        a_reg <= bus;
    end

// B Register
    if (reset) begin
        b_reg <= 8'b0;
    end else if (b_in) begin
        b_reg <= bus;
    end

// Zero Flag
    if (reset) begin
        z_flag <= 1'b0;
    end else if (???) begin        // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        z_flag <= (alu[7:0] == 8'b0);
    end

// Carry Flag
    if (reset) begin
        c_flag <= 1'b0;
    end else if (???) begin        // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        c_flag <= (alu[8] == 1'b1);
    end

// ALU
wire [8:0] alu;
assign alu =
    alu_add  ? ({1'b0, a_reg} + {1'b0, b_reg}) :
    alu_sub  ? ({1'b0, a_reg} - {1'b0, b_reg}) :
    alu_and  ? ({1'b0, a_reg} & {1'b0, b_reg}) :
    alu_or   ? ({1'b0, a_reg} | {1'b0, b_reg}) :
    alu_xor  ? ({1'b0, a_reg} ^ {1'b0, b_reg}) :
                                    // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ??? (9'b0);

// Controller
always @(*) begin
    pc_in     = 1'b0;
    pc_out    = 1'b0; 
    pc_inc    = 1'b0;
    mar_in    = 1'b0;
    ram_in    = 1'b0;
    ram_out   = 1'b0;
    ir_in     = 1'b0;
    ir_out    = 1'b0;
    a_in      = 1'b0;
    a_out     = 1'b0;
    b_in      = 1'b0;
    b_out     = 1'b0;
    alu_op    = 1'b0;
    alu_out   = 1'b0;
    output_in = 1'b0;

    if (~reset) begin

        if (state == 3'd1) begin            // Fetch
            pc_out  = 1'b1;
            mar_in  = 1'b1;
        end else if (state == 3'd2) begin
            ram_out = 1'b1;
            ir_in   = 1'b1;
            pc_inc  = 1'b1;
        end
    end
        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


endmodule
