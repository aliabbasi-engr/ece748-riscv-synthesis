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

// 128MB register file (32 lines, 32-bit)
module Register_File(
    `ifdef USE_POWER_PINS
        inout vdd,
        inout gnd,
    `endif
    input clk, rst,
    input WE3, // write_enable
    input [4:0] A1, A2, A3, // read_addr0, read_addr1, write_addr
    input [31:0] WD3, // write_data
    output [31:0] RD1, RD2 // read_data0, read_data1
    );

    reg [31:0] Register [31:0];

    // write to the Register[write_addr] synchronous to the clock edge
    always @ (negedge clk) begin
        if(WE3)
            Register[A3] <= WD3;
    end

    // continuously assign Register[read_addr] to the output, unless reset == 1'b0
    assign RD1 = (~rst) ? 32'd0 : Register[A1];
    assign RD2 = (~rst) ? 32'd0 : Register[A2];

    /*genvar i;
    generate
        for(i = 1; i < 32; i = i + 1) begin    
            initial begin
                Register[i] = 32'h00000000;
            end
        end
    endgenerate*/
    
endmodule
