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

`include "global.vh"

// this module registers the program counter and assigns
// the next value from an external source (PC_Adder module) at the clock edge
module PC_Module(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input clk, rst,
    input [31:0] PC_Next,
    output reg [31:0] PC
    );

    always @(negedge clk)
    begin
        if(~rst)
            PC <= {32{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule
