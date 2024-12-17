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
input clk,start,branch,zero,stall,
input [width-1:0] immAddress,curr_pc,
output  [31:0] nxt_pc,
output [width-1:0] inst_out,pc_plus4,
output PC_Mux_Sel);

//wire PC_Mux_Sel;
reg temp;

PC main_PC(
.clk(clk),
.rst(start),
.pc_i(nxt_pc),
.pc_o(curr_pc),
.stall(stall)
);

Adder Pc_adder(
.a(curr_pc),
.b(32'h4),
.sum(pc_plus4)
);

InstructionMemory IM(
.readAddr(curr_pc),
.inst(inst_out)
);

always@(posedge clk or branch or zero) begin
    if(branch==1'b0 || branch===1'bx) temp=1'b0;
    else if(branch==1'b1 && zero==1'b1) temp= 1'b1;
end

assign PC_Mux_Sel = temp;

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(PC_Mux_Sel),
    .s0(pc_plus4),
    .s1(immAddress),
    .out(nxt_pc)
);

endmodule
