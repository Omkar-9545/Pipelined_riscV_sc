`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:52:25 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] ALUCtl,
    input [31:0] A,B,
    output reg [31:0] ALUOut,
    output zero
);
    // ALU has two operand, it execute different operator based on ALUctl wire 
    // output zero is for determining taking branch or not 

    // TODO: implement your ALU here
    // Hint: you can use operator to implement
always @(*)
begin
if (ALUCtl == 4'b0000)
 ALUOut = A & B;
else if (ALUCtl == 4'b0001)
 ALUOut = A | B;
else if(ALUCtl == 4'b0010)
 ALUOut = A + B;
else if(ALUCtl == 4'b0110)
ALUOut = A - B;
else if(ALUCtl == 4'b0011)
ALUOut = A << B;
else if(ALUCtl == 4'b0100)
begin
if((~A+1) < (~B+1))
ALUOut = 1;
else 
ALUOut = 0; 
end
else if(ALUCtl == 4'b0101)
begin
if(A < B)
ALUOut = 1;
else 
ALUOut = 0;
end
else if(ALUCtl == 4'b0111)
ALUOut = A ^ B;
else if(ALUCtl == 4'b1000)
ALUOut = A >> B;
else if(ALUCtl == 4'b1010)
ALUOut = A >>> B;
else
 ALUOut = {32{1'bx}};
end 
assign zero = (ALUOut == 0) ? 1 : 0;
    
    
endmodule
