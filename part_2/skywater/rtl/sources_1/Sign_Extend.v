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

module Sign_Extend(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input [31:0] In,
    input [1:0] ImmSrc,
    output [31:0] Imm_Ext
    );

    // assign output of the sign extender based on the instruction
    // then the sign bits are added to make the immediate width 32 bits with the same sign
    assign Imm_Ext = (ImmSrc == 2'b01) ? ({{20{In[31]}},In[31:25],In[11:7]}): // SB, SH, SW
                     (ImmSrc == 2'b10) ? ({In[31], In[8], In[30:25], In[11:8], 1'b0}): // BEQ, BNE, BLT, BGE, BLTU, BGEU
                                         {{20{In[31]}},In[31:20]};
                                
endmodule
