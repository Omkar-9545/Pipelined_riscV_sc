`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 07:53:28 PM
// Design Name: 
// Module Name: ALUCtrl
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


module ALUCtrl(
    input [1:0] ALUOp,
    input funct7,
    input [2:0] funct3,
    output reg [3:0] ALUCtl
);

    // TODO: implement your ALU ALUCtl here
   // Hint: using ALUOp, funct7, funct3 to select exact operation
    always @(*)
begin
case (ALUOp)
2'b00 : ALUCtl <= 4'b0010; //add
2'b01 : ALUCtl <= 4'b0110; //sub
2'b10 : case(funct3)
3'b000 : 
    begin 
    if(~funct7) ALUCtl <= 4'b0010; // add
    else ALUCtl <= 4'b0110; //sub
    end
3'b001 : ALUCtl <= 4'b0011; // sll
3'b100 : ALUCtl <= 4'b0111; // xor
3'b101 : 
         begin
         if(~funct7) ALUCtl <= 4'b1000; // srl
         else ALUCtl <= 4'b1010; //sra
         end
3'b110 : ALUCtl <= 4'b0001; // or
3'b111 : ALUCtl <= 4'b0000; // and
default : ALUCtl <= 4'bxxxx;
endcase
2'b11 : case(funct3)
3'b000 : ALUCtl <= 4'b0010; // addi
3'b001 : ALUCtl <= 4'b0011; // slli
3'b100 : ALUCtl <= 4'b0111; // xori
3'b101 : 
         begin
         if(~funct7) ALUCtl <= 4'b0001; //srli
         else ALUCtl <= 4'b1010; //srai
         end
3'b110 : ALUCtl <= 4'b0001; // ori
3'b111 : ALUCtl <= 4'b0000; //andi
3'b010 : ALUCtl <= 4'b0101; //slti
default : ALUCtl <= 4'bxxxx;
endcase
endcase
end

endmodule
