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

module ALU(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input [31:0] A, B,
    input [2:0] ALUControl,
    output Carry, OverFlow, Zero, Negative,
    output [31:0] Result
    );

    wire Cout;
    wire [31:0] Sum;
    
    // ---------- Single Design Ware add/sub module ----------

    // Instance of DW01_addsub
    DW01_addsub #(
        .width(32)
        ) DW01_addsub_inst (
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .A(A),
        .B(B),
        .CI(1'b0),
        .ADD_SUB(ALUControl[0]),
        .SUM(Sum),
        .CO(Cout)
        );

    // ---------- Separated DesignWare add/sub modules ----------

    wire [31:0] add, sub;
    wire add_co, sub_co;

    // Instance of DW01_add
    /*DW01_add #(
        .width(32)
        ) DW01_add_inst (
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .A(A),
        .B(B),
        .CI(1'b0),
        .SUM(add),
        .CO(add_co)
        );

    // Instance of DW01_sub
    DW01_sub #(
        .width(32)
        ) DW01_sub_inst (
        `ifdef USE_POWER_PINS
            .vdd(vdd),
            .gnd(gnd),
        `endif
        .A(A),
        .B(B),
        .CI(1'b0),
        .DIFF(sub),
        .CO(sub_co)
        );

    assign Sum = (ALUControl[0] == 1'b0) ? add : sub;
    assign Cout = (ALUControl[0] == 1'b0) ? add_co : sub_co;*/

    // ---------- Behavioural add/sub operations ----------

    // add A to B/B-2s-complement
    //assign Sum = (ALUControl[0] == 1'b0) ? A + B : (A + ((~B)+1)) ;
                                          
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : // SLT instruction
                    {32{1'b0}};
    
    // ALU arithmetic flags                       
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule
