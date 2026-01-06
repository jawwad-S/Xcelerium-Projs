`timescale 1ns/1ps

module top_tb;

    reg  [31:0] a, b;
    reg         refclk;
    reg         rst;

    wire [31:0] sum;
    wire        OF;
    wire        outclk_0;
    wire        locked;
    wire        activeclk;

    top dut (
        .a(a),
        .b(b),
        .refclk(refclk),
        .rst(rst),
        .sum(sum),
        .OF(OF),
        .outclk_0(outclk_0),
        .locked(locked),
        .activeclk(activeclk)
    );

    // 50 MHz reference clock
    initial begin
        refclk = 0;
        forever #10 refclk = ~refclk;
    end

    // Reset
    initial begin
        rst = 1;
        a = 0;
        b = 0;
        #100;
        rst = 0;
    end

    // Stimulus
    initial begin
        wait (locked);
        #20;

        a = 10;  b = 20;
        #10;

        a = 100; b = 200;
        #10;

        a = 32'h7FFFFFFF; b = 1;
        #20;

        $finish;
    end

endmodule
