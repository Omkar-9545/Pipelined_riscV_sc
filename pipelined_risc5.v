`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 11:39:23 PM
// Design Name: 
// Module Name: pipelined_risc5
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


module pipelined_risc5 #(parameter width=32)(
input start,clk,

output [width-1:0] nxt_pc,inst_out,

output  [31:0] curr_pc_out,rd2_out,rd1_out,immOut_reg,
output  PC_Mux_Sel,stall,

output zero_out,branch_out,memRead_out,memWrite_out,
output [31:0] immAddress_out,rd2_out_reg,

output regWrite_fin,memtoReg_fin,
output [31:0] DM_read_data_out,ALU_res_fin,
output [4:0] rd_fin
    );

//flush the pipeline
wire flush;

//stage 2 decode output signals going in to ID/EX reg    
wire [31:0] immOut,curr_pc,rd1,rd2,inst,pc_plus4,reg_pc_out;
wire branch,memRead,memtoReg,memWrite,ALUSrc,regWrite,funct7_out;
wire [1:0] ALUOp;
wire [4:0]  readReg1,readReg2,writeReg;
wire [2:0] funct3_out;

//the output of the hazard detection unit
//wire stall;

//used in the execute stage
wire [1:0] ALUOp_out,ALUSrc_out;

//stage 3 execute output signals going into the EX/MEM reg
wire [31:0] immAddress_in,ALUOut;
wire zero_in,branch_reg,memtoReg_reg,memWrite_reg,regWrite_reg,memRead_reg;
wire [4:0] write_reg_out;

//stage 4 mem output signals going into the MEM/WB reg
wire [31:0] DM_read_data,ALU_res_out,wb_data;
wire regWrite_out,memtoReg_out;
wire [4:0] rd_out;

flush_unit cls(PC_Mux_Sel,flush);

Fetch funit(
.clk(clk),
.stall(stall),
.start(start),
.branch(branch_out),
.zero(zero_out),
.immAddress(immAddress_out),
.curr_pc(curr_pc),
.inst_out(inst),
.nxt_pc(nxt_pc),
.pc_plus4(pc_plus4),
.PC_Mux_Sel(PC_Mux_Sel)
);    

IF_ID IfIdreg(
.clk(clk),
.stall(stall),
.flush(flush),
.inst_in(inst),
.curr_pc_val(curr_pc),
.inst_out(inst_out),
.curr_pc(reg_pc_out)
);

Decode dunit(
.inst(inst_out),
.wb_data(wb_data),
.start(start),
.clk(clk),
.stall(stall),
.branch(branch),
.memRead(memRead),
.memtoReg(memtoReg),
.ALUOp(ALUOp),
.memWrite(memWrite),
.ALUSrc(ALUSrc),
.regWrite(regWrite),
.immOut(immOut),
.rd1(rd1),
.rd2(rd2),
.readReg1(readReg1),
.readReg2(readReg2),
.writeReg(writeReg),
.rd(rd_fin),
.rw(regWrite_fin)
    );

ID_EX idexreg(
.clk(clk),
.flush(flush),
.funct7(inst_out[30]),
.branch_in(branch),
.memRead_in(memRead),
.memtoReg_in(memtoReg),
.memWrite_in(memWrite),
.ALUSrc_in(ALUSrc),
.regWrite_in(regWrite),
.ALUOp_in(ALUOp),
.funct3(inst_out[14:12]),
.reg_pc_out(reg_pc_out),
.rd2(rd2),
.rd1(rd1),
.immOut(immOut),
.write_reg(writeReg),
.curr_pc_out(curr_pc_out),
.rd2_out(rd2_out),
.rd1_out(rd1_out),
.immOut_reg(immOut_reg),
.funct3_out(funct3_out),
.funct7_out(funct7_out),
.write_reg_out(write_reg_out),
.branch_out(branch_reg),
.memRead_out(memRead_reg),
.memtoReg_out(memtoReg_reg),
.memWrite_out(memWrite_reg),
.ALUSrc_out(ALUSrc_out),
.regWrite_out(regWrite_reg),
.ALUOp_out(ALUOp_out)
);

Execute eunit(
.ALUOp(ALUOp_out),
.ALUSrc(ALUSrc_out),
.rd1(rd1_out),
.rd2(rd2_out),
.immOut(immOut_reg),
.curr_pc(curr_pc_out),
.ALUOut(ALUOut),
.immAddress(immAddress_in),
.zero(zero_in),
.funct7(funct7_out),
.funct3(funct3_out)
);

EX_MEM exmemreg(
.clk(clk),
.flush(flush),
.zero_in(zero_in),
.branch_in(branch_reg),
.memtoReg_in(memtoReg_reg),
.memWrite_in(memWrite_reg),
.memRead_in(memRead_reg),
.regWrite_in(regWrite_reg),
.immAddress_in(immAddress_in),
.rd2_in(rd2_out),
.ALU_res_in(ALUOut),
.rd_in(write_reg_out),
.zero_out(zero_out),
.branch_out(branch_out),
.memtoReg_out(memtoReg_out),
.memWrite_out(memWrite_out),
.memRead_out(memRead_out),
.regWrite_out(regWrite_out),
.immAddress_out(immAddress_out),
.rd2_out(rd2_out_reg),
.ALU_res_out(ALU_res_out),
.rd_out(rd_out)
);

Memory munit(
.clk(clk),
.start(start),
.memWrite(memWrite_out),
.memRead(memRead_out),
.ALUOut(ALU_res_out),
.rd2(rd2_out_reg),
.DM_read_data(DM_read_data)
);

MEM_WB memwbreg(
.clk(clk),
.flush(flush),
.regWrite(regWrite_out),
.memtoReg(memtoReg_out),
.DM_read_data_in(DM_read_data),
.ALU_res(ALU_res_out),
.rd_in(rd_out),
.regWrite_fin(regWrite_fin),
.memtoReg_fin(memtoReg_fin),
.DM_read_data_out(DM_read_data_out),
.ALU_res_fin(ALU_res_fin),
.rd_fin(rd_fin)
);

WriteBack wunit(
.memtoReg(memtoReg_fin),
.ALUOut(ALU_res_fin),
.DM_read_data(DM_read_data_out),
.wb_data(wb_data)
);

endmodule    
