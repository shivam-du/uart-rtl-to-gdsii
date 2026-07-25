`timescale 1ns / 1ps

/********************************************************************
Module Name : tb_uart_tx

Description :
Testbench for verifying the UART Transmitter module.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module tb_uart_tx;

    parameter DATA_WIDTH = 8;

    reg                     clk;
    reg                     rst;
    reg                     baud_tick;
    reg                     tx_start;
    reg [DATA_WIDTH-1:0]    tx_data;

    wire                    tx;
    wire                    tx_busy;

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
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
        rst      = 1'b1;
        tx_start = 1'b0;
        tx_data  = 8'h00;

        #40;
        rst = 1'b0;

        #100;

        tx_data  = 8'h53;
        tx_start = 1'b1;

        #20;
        tx_start = 1'b0;

        #2500;

        $finish;
    end

    initial begin
        $dumpfile("waveforms/uart_tx.vcd");
        $dumpvars(0, tb_uart_tx);
    end

endmodule