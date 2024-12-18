`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Omkar Chougule
// 
// Create Date: 12/02/2024 12:15:29 PM
// Design Name: 
// Module Name: Decode
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


module Decode #(parameter width=32)(
    input [width-1:0] inst,wb_data,
    input start,clk,stall,
    input [4:0] rd,
    input rw,
    output  branch,
    output  memRead,
    output  memtoReg,
    output  [1:0] ALUOp,
    output  memWrite,
    output  ALUSrc,
    output  regWrite,
    output [width-1:0] immOut,rd1,rd2,
    output [4:0] readReg1,readReg2,writeReg
    );

wire [6:0] opcode;


    assign opcode = inst[6:0];
    
    Control control_unit(
    .opcode(opcode),
    .branch(branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp(ALUOp),
    .memWrite(memWrite),
    .ALUSrc(ALUSrc),
    .regWrite(regWrite),
    .stall(stall)
    );
    
assign readReg1 = inst[19:15];
assign readReg2 = inst[24:20];
assign writeReg = inst[11:7];

Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(rw),
    .readReg1(readReg1),
    .readReg2(readReg2),
    .writeReg(rd),
    .writeData(wb_data),
    .readData1(rd1),
    .readData2(rd2)
);


ImmGen #(.Width(32)) m_ImmGen(
    .inst(inst),
    .imm(immOut)
);
    
endmodule
