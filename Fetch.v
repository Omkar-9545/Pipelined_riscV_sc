`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 11:23:44 AM
// Design Name: 
// Module Name: Fetch
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


module Fetch #(parameter width=32)(
input clk,start,branch,zero,
input [width-1:0] immAddress,curr_pc,
output [width-1:0] inst_out,nxt_pc,pc_plus4);

wire PC_Mux_Sel;

PC main_PC(
.clk(clk),
.rst(start),
.pc_i(curr_pc),
.pc_o(nxt_pc)
);

Adder Pc_adder(
.a(nxt_pc),
.b(32'h4),
.sum(pc_plus4)
);

InstructionMemory IM(
.readAddr(nxt_pc),
.inst(inst_out)
);

assign PC_Mux_Sel = branch & zero;

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(PC_Mux_Sel),
    .s0(pc_plus4),
    .s1(immAddress),
    .out(curr_pc)
);

endmodule
