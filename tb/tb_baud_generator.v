`timescale 1ns / 1ps

/********************************************************************
Module Name : tb_baud_generator

Description :
Testbench for UART Baud Generator

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module tb_baud_generator;

    reg clk;
    reg rst;
    wire baud_tick;

    baud_generator #(
        .CLK_FREQ(100),
        .BAUD_RATE(10)
    ) dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    initial begin
        clk = 1'b0;
    end

    always #10 clk = ~clk;

    initial begin
        rst = 1'b1;
        #30;
        rst = 1'b0;
    end

    initial begin
        $dumpfile("waveforms/baud_generator.vcd");
        $dumpvars(0, tb_baud_generator);
    end

    initial begin
        #500;
        $finish;
    end

endmodule