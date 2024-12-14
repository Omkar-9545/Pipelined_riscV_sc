`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 10:48:36 PM
// Design Name: 
// Module Name: Execute
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Execute #(parameter width=32)(
input [1:0] ALUOp,
input ALUSrc,
input [width-1:0] rd1,rd2,inst,immOut,curr_pc,
output [width-1:0] ALUOut,immAddress,
output zero
    );

wire funct7;
wire [2:0] funct3;
wire [3:0] ALUCtl;
wire [31:0] Operand2,shiftOut;

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(ALUSrc),
    .s0(rd2),
    .s1(immOut),
    .out(Operand2)
);

assign funct7 = inst[30];
assign funct3 = inst[14:12];

ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(funct7),
    .funct3(funct3),
    .ALUCtl(ALUCtl)
);

ALU m_ALU(
    .ALUCtl(ALUCtl),
    .A(rd1),
    .B(Operand2),
    .ALUOut(ALUOut),
    .zero(zero)
);  

ShiftLeftOne m_ShiftLeftOne(
    .i(immOut),
    .o(shiftOut)
);

Adder m_Adder_2(
    .a(curr_pc),
    .b(shiftOut),
    .sum(immAddress)
);

endmodule
