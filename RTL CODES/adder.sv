module adder(
    input logic cin,
    input  logic [31:0] a, b,
    output logic co,
    output logic OF,
    output logic [31:0] sum
);
 //   assign sum = a + b;
	always_comb begin
		{co, sum} = a + b + cin;
	end
	assign OF = ((a[31] & b[31] & ~sum[31]) | (~a[31] & ~b[31] & sum[31]));
endmodule

