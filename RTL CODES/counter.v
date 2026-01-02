module counter #(parameter N = 8) (
    input clk,
    input rst_n,
    input en, up_dn,
    output reg [N-1:0] count
);

always @(posedge clk) begin
    if (!rst_n)
        count <= {N{1'b0}};
    else
        if(en)
		count <= up_dn ? count - 1 : count + 1;
	else
		count <= count;
			
end

endmodule

