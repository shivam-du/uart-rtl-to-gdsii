`timescale 1ns / 1ps

/********************************************************************
Module Name : tb_uart_top

Description :
System-level testbench for verifying the complete UART IP.

Author : Shivam Chaurasiya

Project :
UART ASIC IP

Version : 1.0

********************************************************************/

module tb_uart_top;

    parameter CLK_FREQ   = 100;
    parameter BAUD_RATE  = 10;
    parameter DATA_WIDTH = 8;

    reg                     clk;
    reg                     rst;

    reg                     tx_start;
    reg [DATA_WIDTH-1:0]    tx_data;

    wire                    tx;
    wire                    tx_busy;

    wire [DATA_WIDTH-1:0]   rx_data;
    wire                    rx_done;

    wire                    rx;

    assign rx = tx;

    uart_top #(

        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE),
        .DATA_WIDTH(DATA_WIDTH)

    ) dut (

        .clk(clk),
        .rst(rst),

        .tx_start(tx_start),
        .tx_data(tx_data),

        .rx(rx),

        .tx(tx),
        .tx_busy(tx_busy),

        .rx_data(rx_data),
        .rx_done(rx_done)

    );

    initial
        clk = 1'b0;

    always
        #10 clk = ~clk;

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

        @(posedge rx_done);

        if (rx_data == 8'h53)
            $display("[%0t] TEST-1 PASS : Received = %h", $time, rx_data);
        else
            $display("[%0t] TEST-1 FAIL : Received = %h", $time, rx_data);

        #200;

        tx_data  = 8'hA5;
        tx_start = 1'b1;

        #20;
        tx_start = 1'b0;

        @(posedge rx_done);

        if (rx_data == 8'hA5)
            $display("[%0t] TEST-2 PASS : Received = %h", $time, rx_data);
        else
            $display("[%0t] TEST-2 FAIL : Received = %h", $time, rx_data);


        #200;

        $display("------------------------------------------");
        $display(" UART Top-Level Verification Completed");
        $display("------------------------------------------");

        $finish;

    end

    initial begin

        $dumpfile("waveforms/uart_top.vcd");
        $dumpvars(0, tb_uart_top);

    end

endmodule