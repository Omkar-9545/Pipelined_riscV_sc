`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2024 11:01:45 PM
// Design Name: 
// Module Name: single_cycle_cpu
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


module single_cycle_cpu #(parameter width=32)(
input start,clk,
output branch,memRead,memtoReg,memWrite,ALUSrc,regWrite,zero,
output [1:0] ALUOp,
output [width-1:0] inst,rd1,rd2,nxt_pc,pc_plus4,immAddress,curr_pc,immOut,ALUOut,DM_read_data,wb_data,
output [4:0] readReg1,readReg2,writeReg
    );
    
Fetch funit(
.clk(clk),
.start(start),
.branch(branch),
.zero(zero),
.immAddress(immAddress),
.curr_pc(curr_pc),
.inst_out(inst),
.nxt_pc(nxt_pc),
.pc_plus4(pc_plus4)
);    

Decode dunit(
.inst(inst),
.wb_data(wb_data),
.start(start),
.clk(clk),
.branch(branch),
.memRead(memRead),
.memtoReg(memtoReg),
.ALUOp(ALUOp),
.memWrite(memWrite),
.ALUSrc(ALUSrc),
.regWrite(regWrite),
.immOut(immOut),
.rd1(rd1),
.rd2(rd2),
.readReg1(readReg1),
.readReg2(readReg2),
.writeReg(writeReg)
    );

Execute eunit(
.ALUOp(ALUOp),
.ALUSrc(ALUSrc),
.rd1(rd1),
.rd2(rd2),
.inst(inst),
.immOut(immOut),
.curr_pc(curr_pc),
.ALUOut(ALUOut),
.immAddress(immAddress),
.zero(zero)
);

Memory munit(
.clk(clk),
.start(start),
.memWrite(memWrite),
.memRead(memRead),
.ALUOut(ALUOut),
.rd2(rd2),
.DM_read_data(DM_read_data)
);

WriteBack wunit(
.memtoReg(memtoReg),
.ALUOut(ALUOut),
.DM_read_data(DM_read_data),
.wb_data(wb_data)
);

endmodule

