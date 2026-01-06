`timescale 1 ps / 1 ps

module bram_top(
input clk, RE, WE,
input [7:0] addrs,
input [7:0] data,
output [7:0] q
);


//bram inst
BRAM dut (
.address(addrs),
.clock(clk),
.data(data),
.rden(RE),
.wren(WE),
.q(q)
);

endmodule
