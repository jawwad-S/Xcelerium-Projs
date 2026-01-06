`timescale 1 ns / 1 ps

module top (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire        refclk,
    input  wire        rst,
    output wire [31:0] sum,
    output wire        OF,
    output wire        outclk_0,
    output wire        locked,
    output wire        activeclk
);

reg [31:0] mem;

ADDER dut (
.dataa(a),
.datab(b),
.overflow(OF),
.result(sum)
);

PLL pll (
		.refclk    (refclk),    //    refclk.clk
		.rst       (rst),       //     reset.reset
		.outclk_0  (outclk_0),  //   outclk0.clk
		.locked    (locked),    //    locked.export
		.refclk1   (1'b0),   //   refclk1.refclk1
		.activeclk (activeclk)  // activeclk.activeclk
);


always@(posedge outclk_0) begin
if(rst || !locked)
	mem <= 32'h0;
else 
	mem <= sum;
	$display("data written in reg: %h", sum);
end


endmodule
 