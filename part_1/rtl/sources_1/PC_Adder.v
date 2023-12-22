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

// a behavioural implementation for a simple 32-bit adder used for PC
// ports are assigned in the following manner at the top level:
// a <= PC
// b <= 'h4
// PC_Next <= c
module PC_Adder (a,b,c);

    parameter IM_ADDR_WIDTH = 9;

    input [31:0]a,b;
    output [31:0]c;
    
    assign c = (a + b) & {{32 - IM_ADDR_WIDTH{1'b0}}, {IM_ADDR_WIDTH{1'b1}}};
    
endmodule
