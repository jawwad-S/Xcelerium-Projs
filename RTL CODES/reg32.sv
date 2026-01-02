module reg32(
input logic clk, rst_n, load,
input logic [31:0]d,
output logic [31:0]q
);

always@(posedge clk) begin
/*if(!rst_n)
	q <= 32'd0;
else*/ if(load)
	q <= d;
end

endmodule 