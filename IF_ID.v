`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 09:48:46 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input clk,stall,flush,
input [31:0] inst_in,curr_pc_val,
output reg [31:0] inst_out,curr_pc
    );
    
    always@(posedge clk) 
    begin
        if(flush==1'b1) begin
            inst_out <= 32'b0;
            curr_pc <= 32'b0;
        end
        else if (stall==1'b0) 
            begin
            inst_out <= inst_in;
            curr_pc <= curr_pc_val;
            end
    end

endmodule
