`timescale 1 ps / 1 ps

module bram_top_tb;

reg clk,RE,WE;
reg [7:0] data, addrs;
wire [7:0] q;

bram_top top_tb (
.addrs(addrs),
.clk(clk),
.data(data),
.RE(RE),
.WE(WE),
.q(q)
);

initial begin
clk = 0;
data = 8'h00;
WE = 0;
RE = 1;
end

always
#10 clk = ~clk;

initial begin
#10
WE = 1;
data = 8'haa;
addrs = 8'hff;
#10
data = 8'hba;
addrs = 8'hfa;
#10
RE = 0;
WE = 0;
addrs = 8'hff;

#200 $finish;
end

endmodule
