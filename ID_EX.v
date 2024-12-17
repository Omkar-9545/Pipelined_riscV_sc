`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 12:17:39 AM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input clk,flush,funct7,branch_in,memRead_in,memtoReg_in,memWrite_in,ALUSrc_in,regWrite_in,
input [1:0] ALUOp_in,
input [2:0] funct3,
input [31:0] reg_pc_out,rd2,rd1,immOut,
input [4:0] write_reg,
output reg [31:0] curr_pc_out,rd2_out,rd1_out,immOut_reg,
output reg [2:0] funct3_out,
output reg funct7_out,
output reg [4:0] write_reg_out,
output  reg branch_out,memRead_out,memtoReg_out,memWrite_out,ALUSrc_out,regWrite_out, 
output  reg [1:0] ALUOp_out
    );
    
always@(posedge clk)begin
if(flush==1'b1) 
    begin
        curr_pc_out <=32'd0;
        rd2_out <= 32'd0;
        rd1_out <= 32'd0;
        immOut_reg <=32'd0;
        funct3_out <= 3'b0;
        funct7_out <=1'b0;
        write_reg_out <= 5'b0;
        branch_out <= 1'b0;
        memRead_out <= 1'b0;
        memtoReg_out <= 1'b0;
        memWrite_out <= 1'b0;
        ALUSrc_out <= 1'b0;
        regWrite_out <= 1'b0;
        ALUOp_out <= 2'b0;
    end
else 
    begin
        curr_pc_out <= reg_pc_out;
        rd2_out <= rd2;
        rd1_out <= rd1;
        immOut_reg <= immOut;
        funct3_out <= funct3;
        funct7_out <= funct7;
        write_reg_out <= write_reg;
        branch_out <= branch_in;
        memRead_out <= memRead_in;
        memtoReg_out <= memtoReg_in;
        memWrite_out <= memWrite_in;
        ALUSrc_out <= ALUSrc_in;
        regWrite_out <= regWrite_in;
        ALUOp_out <= ALUOp_in;
    end
end
        
endmodule
