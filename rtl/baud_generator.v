`timescale 1ns / 1ps

/********************************************************************
Module Name : baud_generator

Description :
Generates a single clock cycle baud tick for UART transmission
and reception.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module baud_generator #(
    parameter integer CLK_FREQ  = 50_000_000,
    parameter integer BAUD_RATE = 9_600
)(
    input  wire clk,
    input  wire rst,
    output reg  baud_tick
);

    localparam integer BAUD_DIV = CLK_FREQ / BAUD_RATE;

    reg [$clog2(BAUD_DIV)-1:0] counter;

    always @(posedge clk) begin

        if (rst) begin
            counter   <= 0;
            baud_tick <= 1'b0;
        end

        else begin

            if (counter == BAUD_DIV - 1) begin
                counter   <= 0;
                baud_tick <= 1'b1;
            end

            else begin
                counter   <= counter + 1;
                baud_tick <= 1'b0;
            end

        end

    end

endmodule