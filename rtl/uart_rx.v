`timescale 1ns / 1ps

/********************************************************************
Module Name : uart_rx

Description :
UART Receiver module. Receives serial UART data and reconstructs
the original 8-bit parallel data.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module uart_rx #(
    parameter integer DATA_WIDTH = 8
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   baud_tick,
    input  wire                   rx,

    output reg [DATA_WIDTH-1:0]   rx_data,
    output reg                    rx_done
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
            rx_data       <= {DATA_WIDTH{1'b0}};
            rx_done       <= 1'b0;

        end

        else begin

            case (current_state)

                IDLE: begin

                    rx_done <= 1'b0;

                    if (rx == 1'b0) begin
                        bit_count     <= 0;
                        current_state <= START;
                    end

                end

                START: begin

                    rx_done <= 1'b0;

                    if (baud_tick) begin

                        if (rx == 1'b0)
                            current_state <= DATA;
                        else
                            current_state <= IDLE;

                    end

                end

                DATA: begin

                    rx_done <= 1'b0;

                    if (baud_tick) begin

                        shift_reg <= {rx, shift_reg[DATA_WIDTH-1:1]};

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

                    rx_done <= 1'b0;

                    if (baud_tick) begin

                        if (rx == 1'b1) begin
                            rx_data <= shift_reg;
                            rx_done <= 1'b1;
                        end

                        bit_count     <= 0;
                        current_state <= IDLE;

                    end

                end

                default: begin

                    current_state <= IDLE;
                    shift_reg     <= {DATA_WIDTH{1'b0}};
                    bit_count     <= 0;
                    rx_done       <= 1'b0;

                end

            endcase

        end

    end

endmodule