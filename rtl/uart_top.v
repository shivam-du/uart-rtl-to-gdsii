`timescale 1ns / 1ps

/********************************************************************
Module Name : uart_top

Description :
Top-level UART module. Integrates the baud generator,
UART transmitter, and UART receiver into a complete UART IP.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module uart_top #(

    parameter integer CLK_FREQ   = 50_000_000,
    parameter integer BAUD_RATE  = 9600,
    parameter integer DATA_WIDTH = 8

)(

    input  wire                   clk,
    input  wire                   rst,

    input  wire                   tx_start,
    input  wire [DATA_WIDTH-1:0]  tx_data,

    input  wire                   rx,

    output wire                   tx,
    output wire                   tx_busy,

    output wire [DATA_WIDTH-1:0]  rx_data,
    output wire                   rx_done

);

    wire baud_tick;

    baud_generator #(

        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)

    ) baud_gen (

        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)

    );

    uart_tx #(

        .DATA_WIDTH(DATA_WIDTH)

    ) transmitter (

        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),

        .tx_start(tx_start),
        .tx_data(tx_data),

        .tx(tx),
        .tx_busy(tx_busy)

    );

    uart_rx #(

        .DATA_WIDTH(DATA_WIDTH)

    ) receiver (

        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),

        .rx(rx),

        .rx_data(rx_data),
        .rx_done(rx_done)

    );

endmodule