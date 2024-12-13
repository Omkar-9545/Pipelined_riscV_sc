`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Omkar Chougule
// 
// Create Date: 12/04/2024 11:04:49 PM
// Design Name: 
// Module Name: Memory
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


module Memory #(parameter width=32)(
input clk,start,memWrite,memRead,
input [width-1:0] ALUOut,rd2,
output [width-1:0] DM_read_data
    );
    
DataMemory m_DataMemory(
    .rst(start),
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(ALUOut),
    .writeData(rd2),
    .readData(DM_read_data)
);    




endmodule
