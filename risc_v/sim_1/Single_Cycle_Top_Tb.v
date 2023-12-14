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

module Single_Cycle_Top_Tb ();
    
    parameter CLOCK_PULSE_WIDTH = 50;
    
    reg clk=1'b1,rst;
    reg [31:0] multiplier, multiplicand, expected_result, result;
    
    // DUT instantiation
    Single_Cycle_Top Single_Cycle_Top(
                                .clk(clk),
                                .rst(rst)
    );
    
    initial begin
        $dumpfile("Single Cycle.vcd");
        $dumpvars(0);
    end
    
    // generate clock signal
    always begin
        clk = ~ clk;
        #CLOCK_PULSE_WIDTH;  
    end
    
    // initialize instruction memory from file
    `ifdef XILINX_SIMULATOR
        initial begin
            $readmemb("im.mem", Single_Cycle_Top.Instruction_Memory.mem);
        end
    `endif
    `ifdef VCS
        initial begin
            $readmemb("rtl/sources_1/mif/im.mem", Single_Cycle_Top.Instruction_Memory.mem);
        end
    `endif
    `ifdef XCELIUM
        initial begin
            $readmemb("rtl/sources_1/mif/im.mem", Single_Cycle_Top.Instruction_Memory.mem);
        end
    `endif
    
    // inititalize reg[0] in register file with 0
    initial begin
        Single_Cycle_Top.Register_File.Register[0] = 32'd0;
    end
    
    initial begin : tb_block_main
    
        reg [7:0] i;
        for(i = 0; i < 3; i = i + 1) begin
        
            // do reset
            rst <= 1'b0;
            #(3 * CLOCK_PULSE_WIDTH);
            rst <=1'b1;
        
            // assign multiplier and multiplicand
            multiplier = 32'hffffffff & {$random}%15;
            multiplicand = 32'hffffffff & {$random}%15;
        
            // load multiplier and multiplicant into register file
            Single_Cycle_Top.Register_File.Register[1] = multiplier;
            Single_Cycle_Top.Register_File.Register[2] = multiplicand;
        
            // wait enough time to perform multiplication
            #(8 * CLOCK_PULSE_WIDTH * multiplier)
        
            // calculate expected result and read exact result from register file
            expected_result = multiplier * multiplicand;
            result = Single_Cycle_Top.Register_File.Register[3];
            
            $display("-------------------------------------");
            $display("multiplier = %0d, multiplicand = %0d", multiplier, multiplicand);
            $display("expected_result = %0d, result = %0d", expected_result, result);
        
            if(expected_result == result) begin
                $display("Result matches the expected value!");
            end
            else begin
                $display("Result does not match the expected value!");
            end        
        end  
        $display("-------------------------------------");
        $finish;
    end
    
endmodule
