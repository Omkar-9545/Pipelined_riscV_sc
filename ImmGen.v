`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:55:06 PM
// Design Name: 
// Module Name: ImmGen
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

    module ImmGen#(parameter Width = 32) (
    input [Width-1:0] inst,
    output reg signed [Width-1:0] imm
);
    // ImmGen generate imm value based on opcode

            // TODO: implement your ImmGen here
            // Hint: follow the RV32I opcode map table to set imm value
            
    wire [6:0] opcode = inst[6:0];
    always @(*) 
    begin
        case(opcode)
        7'b0000011: imm <={{{Width-12}{inst[31]}},inst[31:20]}; //lw type
        7'b0100011: imm <={{{Width-12}{inst[31]}},inst[31:25],inst[11:7]}; //S type
        7'b1100011: imm <={{{Width-11}{inst[31]}},inst[7],inst[30:25],inst[11:8]}; //SB type
        7'b0010011: imm <={{{Width-12}{inst[31]}},inst[31:20]}; //I type
        default: imm <= 32'b0;
	endcase
    end
            
endmodule
