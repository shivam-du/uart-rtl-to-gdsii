`timescale 1ns / 1ps

/********************************************************************
Module Name : uart_tx

Description :
UART Transmitter module. Converts 8-bit parallel data into serial
UART data using start bit, data bits (LSB first), and stop bit.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module uart_tx #(
    parameter integer DATA_WIDTH = 8
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   baud_tick,
    input  wire                   tx_start,
    input  wire [DATA_WIDTH-1:0]  tx_data,

    output reg                    tx,
    output reg                    tx_busy
);

    localparam [1:0]
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11;

    reg [1:0] current_state;
    reg [DATA_WIDTH-1:0] shift_reg;
    reg [$clog2(DATA_WIDTH)-1:0] bit_count;

    always @(posedge clk) begin

        if (rst) begin

            current_state <= IDLE;
            shift_reg     <= {DATA_WIDTH{1'b0}};
            bit_count     <= 0;
            tx            <= 1'b1;
            tx_busy       <= 1'b0;

        end

        else begin

            case (current_state)

                IDLE: begin

                    tx      <= 1'b1;
                    tx_busy <= 1'b0;

                    if (tx_start) begin
                        shift_reg     <= tx_data;
                        bit_count     <= 0;
                        tx_busy       <= 1'b1;
                        current_state <= START;
                    end

                end

                START: begin

                    tx_busy <= 1'b1;

                    if (baud_tick) begin
                        tx            <= 1'b0;
                        current_state <= DATA;
                    end

                end

                DATA: begin

                    tx_busy <= 1'b1;

                    if (baud_tick) begin

                        tx        <= shift_reg[0];
                        shift_reg <= shift_reg >> 1;

                        if (bit_count == DATA_WIDTH-1) begin
                            bit_count     <= 0;
                            current_state <= STOP;
                        end

                        else begin
                            bit_count <= bit_count + 1;
                        end

                    end

                end

                STOP: begin

                    tx_busy <= 1'b1;

                    if (baud_tick) begin
                        tx            <= 1'b1;
                        tx_busy       <= 1'b0;
                        current_state <= IDLE;
                    end

                end

                default: begin

                    current_state <= IDLE;
                    tx            <= 1'b1;
                    tx_busy       <= 1'b0;

                end

            endcase

        end

    end

endmodule