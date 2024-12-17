`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 10:00:10 PM
// Design Name: 
// Module Name: flush_unit
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


module flush_unit(
input main_branch,
output reg flush
    );
    
 initial begin
 flush = 1'b0; 
 end   

always @(*)
    begin
      if (main_branch == 1'b1)
        flush = 1'b1;
      else
        flush = 1'b0;
    end

    
endmodule
