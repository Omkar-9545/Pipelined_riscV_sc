`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:54:03 PM
// Design Name: 
// Module Name: Control
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


module Control(
    input [6:0] opcode,
    output  branch,
    output  memRead,
    output  memtoReg,
    output  [1:0] ALUOp,
    output  memWrite,
    output  ALUSrc,
    output  regWrite
    );
    
    reg [7:0] controlLines;
    
    assign {branch,memRead,memtoReg,memWrite,ALUSrc,regWrite,ALUOp}=controlLines;

    // TODO: implement your Control here
    // Hint: follow the Architecture to set output signal
    
    always@(opcode) begin
    case(opcode)
    7'b0110011: controlLines <= 8'b00000110; //R-type
    7'b0000011: controlLines <= 8'b01101100; //lw-type
    7'b0100011: controlLines <= 8'b00011000; //S-type
    7'b1100011: controlLines <= 8'b10000001; //SB-type
    7'b0010011: controlLines <= 8'b00001111; //I-type
    default : controlLines <= 8'b00000000; //nop
    endcase
    end
endmodule
