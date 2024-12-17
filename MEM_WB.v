`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 09:20:59 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
input clk,flush,regWrite,memtoReg,
input [31:0] DM_read_data_in,ALU_res,
input [4:0] rd_in,
output reg regWrite_fin,memtoReg_fin,
output reg [31:0] DM_read_data_out,ALU_res_fin,
output reg [4:0] rd_fin
    );
    
always@(posedge clk) 
begin
    if(flush==1'b1) 
    begin
        regWrite_fin <= 1'b0;
        memtoReg_fin <= 1'b0;
        DM_read_data_out <= 32'b0;
        ALU_res_fin <= 32'b0;
        rd_fin <= 5'b0;        
    end
    else 
    begin
        regWrite_fin <= regWrite;
        memtoReg_fin <= memtoReg;
        DM_read_data_out <= DM_read_data_in;
        ALU_res_fin <= ALU_res;
        rd_fin <= rd_in;        
    end
end
    
endmodule
