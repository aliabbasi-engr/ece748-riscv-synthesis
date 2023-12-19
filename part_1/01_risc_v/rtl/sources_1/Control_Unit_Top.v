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

/*`include "ALU_Decoder.v"
`include "Main_Decoder.v"*/
`include "global.vh"

module Control_Unit_Top(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input [6:0] Op, funct7,
    input [2:0] funct3,
    input Zero,
    output RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
    );

    wire [1:0]ALUOp;

    Main_Decoder Main_Decoder(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .Op(Op),
        .funct3(funct3),
        .Zero(Zero),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );


endmodule
