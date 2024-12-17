`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 02:29:33 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
input clk,flush,zero_in,branch_in,memtoReg_in,memWrite_in,memRead_in,regWrite_in,
input [31:0] immAddress_in,rd2_in,ALU_res_in,
input [4:0] rd_in,
output reg zero_out,branch_out,memtoReg_out,memWrite_out,memRead_out,regWrite_out,
output reg [31:0] immAddress_out,rd2_out,ALU_res_out,
output reg [4:0] rd_out
    );
    
always@(posedge clk) begin
    if(flush==1'b1) 
    begin 
        zero_out <= 1'b0;
        branch_out <= 1'b0;
        memtoReg_out <= 1'b0;
        memWrite_out <= 1'b0;
        memRead_out <= 1'b0;
        regWrite_out <= 1'b0;
        immAddress_out <= 32'b0;
        rd2_out <= 32'b0;
        ALU_res_out <= 32'b0;
        rd_out <= 5'b0;
    end
    else
    begin
        zero_out <= zero_in;
        branch_out <= branch_in;
        memtoReg_out <= memtoReg_in;
        memWrite_out <= memWrite_in;
        memRead_out <= memRead_in;
        regWrite_out <= regWrite_in;
        immAddress_out <= immAddress_in;
        rd2_out <= rd2_in;
        ALU_res_out <= ALU_res_in;
        rd_out <= rd_in;
    end
end
    
endmodule
