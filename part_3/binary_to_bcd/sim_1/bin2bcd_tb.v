`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2023 12:45:21 PM
// Design Name: 
// Module Name: bin2bcd_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define NUM_SEQUENCE 4

module bin2bcd_tb();
    
    parameter CLOCK_PULSE_WIDTH = 10;
    parameter TCQ = 0.1;
    parameter W = 4;
    
    reg i_clk = 1'b1;
    reg i_rstn = 1'b0;
    reg [W - 1 : 0] i_bin = 0;
    wire [W + (W - 4) / 3 : 0] o_bcd;
    reg [W - 1 : 0] bin = 0;
        
    reg [7:0] i = 0;
    
    // -------------------------------------------
    // ---------------- Dump VCD -----------------
    // -------------------------------------------
    
    initial begin
        $dumpfile("bin2bcd.vcd");
        $dumpvars(0);
    end
    
    // -------------------------------------------
    // ------------ DUT Instantiation ------------
    // -------------------------------------------
    
    bin2bcd#(
        .TCQ(TCQ),
        .W(W)
        ) bin2bcd_inst (
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_bin(i_bin),
        .o_bcd(o_bcd)
    ); 
    
    // -------------------------------------------
    // ------------- Generate Clock --------------
    // -------------------------------------------
    
    // generate clock signal
    always begin
        i_clk = ~i_clk;
        #CLOCK_PULSE_WIDTH;  
    end
    
    // -------------------------------------------
    // ---------------- Stimulus -----------------
    // -------------------------------------------
    
    initial begin : tb_block_main
        
        // do reset
        i_rstn <= 1'b0;
        #(2 * CLOCK_PULSE_WIDTH);
        i_rstn <=1'b1;
        
        for(i = 0; i < `NUM_SEQUENCE; i = i + 1) begin
            
            i_bin = {W{1'b1}} & {$random}%(2**W-1);
            //i_bin = bin;
            
            #(4 * CLOCK_PULSE_WIDTH)
            
            $display("-------------------------------------");
            $display("input_binary(DECIMAL) = %0d, output_BCD = %0b", i_bin, o_bcd);
            
        end
        
        $display("-------------------------------------");
        $display("Ali Abbasi, Derek Furtado");
        $display("ECE748@McMaster - Fall2023");
        $display("-------------------------------------");
        
        $finish;
        
    end
    
endmodule
