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

// 256MB instruction memory (64 lines, 32-bit)
module Instruction_Memory(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input rst,
    input [31:0] A, // read address
    output [31:0] RD // read data
    );

  reg [31:0] mem [63:0];
  
  // continuously assign mem[read_address] to the output, unless reset == 1'b0
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

  // initialize memory from file
  /*`ifdef XILINX_SIMULATOR
    initial begin
        $readmemb("im.mem",mem);
    end
  `endif
  `ifdef VCS
    initial begin
        $readmemb("rtl/sources_1/mif/im.mem",mem);
    end
  `endif*/
  
endmodule
