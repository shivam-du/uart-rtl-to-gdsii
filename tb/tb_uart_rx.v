`timescale 1ns / 1ps

/********************************************************************
Module Name : tb_uart_rx

Description :
Testbench for verifying the UART Receiver module.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module tb_uart_rx;

    parameter DATA_WIDTH = 8;

    reg                     clk;
    reg                     rst;
    reg                     baud_tick;
    reg                     rx;

    wire [DATA_WIDTH-1:0]   rx_data;
    wire                    rx_done;

    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .rx(rx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    initial clk = 1'b0;
    always #10 clk = ~clk;

    initial begin
        baud_tick = 1'b0;

        forever begin
            #100 baud_tick = 1'b1;
            #20  baud_tick = 1'b0;
        end
    end

    initial begin

        rst = 1'b1;
        rx  = 1'b1;

        #40;
        rst = 1'b0;

        #120;

        // Start Bit
        rx = 1'b0;
        #120;

        // Data = 8'h53 (01010011)
        // UART transmits LSB first

        rx = 1'b1;  // b0
        #120;

        rx = 1'b1;  // b1
        #120;

        rx = 1'b0;  // b2
        #120;

        rx = 1'b0;  // b3
        #120;

        rx = 1'b1;  // b4
        #120;

        rx = 1'b0;  // b5
        #120;

        rx = 1'b1;  // b6
        #120;

        rx = 1'b0;  // b7
        #120;

        // Stop Bit
        rx = 1'b1;
        #240;

        $finish;

    end

    initial begin
        $dumpfile("waveforms/uart_rx.vcd");
        $dumpvars(0, tb_uart_rx);
    end

endmodule