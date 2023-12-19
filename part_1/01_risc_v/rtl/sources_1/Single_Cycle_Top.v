// Copyright 2023 MERL-DSU

//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at

//        http://www.apache.org/licenses/LICENSE-2.0

//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

`timescale 1ns/1ps

/*`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"*/
`include "global.v"

module Single_Cycle_Top(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input clk,
    input rst,
    input im_web,
    input [31:0] im_din,
    output [31:0] dm_dout
    );

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;
    wire Zero;
    wire PCSrc;
    wire [31:0] PCTarget, PCNext;

    assign dm_dout = ReadData;

    PC_Module PC(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCNext)
    );

    PC_Adder PC_Adder_4(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );
    
    PC_Adder PC_Adder_Imm(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .a(PC_Top),
        .b(Imm_Ext_Top),
        .c(PCTarget)
    );
    
    Mux Mux_PCNext(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .a(PCPlus4),
        .b(PCTarget),
        .s(PCSrc),
        .c(PCNext)
    );
    
    /*Instruction_Memory Instruction_Memory(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );*/
    
    SRAM_32x64_1rw Instruction_Memory(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .clk0(clk),
        .csb0(1'b0),
        .web0(im_web),
        .addr0(PC_Top[7:2]),
        .din0(im_din),
        .dout0(RD_Instr)
    );

    Register_File Register_File(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .In(RD_Instr),
        .ImmSrc(ImmSrc),
        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );

    ALU ALU(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(Zero),
        .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Zero(Zero),
        .PCSrc(PCSrc),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),
        .ALUControl(ALUControl_Top)
    );

    /*Data_Memory Data_Memory(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .clk(clk),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALUResult),
        .RD(ReadData)
    );*/
    
    SRAM_32x64_1rw Data_Memory(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .clk0(clk),
        .csb0(1'b0),
        .web0(!MemWrite),
        .addr0(ALUResult[5:0]),
        .din0(RD2_Top),
        .dout0(ReadData)
    );

    Mux Mux_DataMemory_to_Register(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Result)
    );

endmodule
