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

`include "global.v"

module Main_Decoder(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input [6:0] Op,
    input [2:0] funct3,
    input Zero,
    output RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc,
    output [1:0]ImmSrc, ALUOp
    );

    // register file load_enable
    assign RegWrite = (Op == 7'b0000011) ? 1'b1 : // LB, LH, LW, LBU, LHU
                      (Op == 7'b0110011) ? 1'b1 : // R-type
                      (Op == 7'b0010011) ? 1'b1 : // I-type
                      1'b0 ;
                      
    // sign extender control signal
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 :
                    (Op == 7'b1100011) ? 2'b10 : // BEQ, BNE, BLT, BGE, BLTU, BGEU
                                         2'b00 ;
                                         
    // ALU second input multiplexer select line to select register file read_data or sign extender output                                    
    assign ALUSrc = (Op == 7'b0100011) ? 1'b1 :
                    (Op == 7'b0100011) ? 1'b1 :
                    (Op == 7'b0010011) ? 1'b1 : // I-type
                                         1'b0 ;
                                                            
    // data memory write-enable                                                        
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
                                           1'b0 ;
                                           
    // register file write_data multiplexer select line to select ALU output or data memory read_data
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
                                            1'b0 ;
    
    assign PCSrc = (Op == 7'b1100011 && funct3 == 3'b000 && Zero == 1'b1) ? 1'b1 : // BEQ
                   (Op == 7'b1100011 && funct3 == 3'b001 && Zero == 1'b0) ? 1'b1 : // BNE
                    1'b0 ;
                                         
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                   (Op == 7'b1100011) ? 2'b01 : // BEQ, BNE, BLT, BGE, BLTU, BGEU
                   (Op == 7'b0010011) ? 2'b00 : // I-type
                                        2'b00 ;

endmodule
