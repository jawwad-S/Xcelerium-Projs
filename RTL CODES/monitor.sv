module monitor #(parameter N = 8)(
input logic rst_n, en, up_dn,
input logic [N-1:0] count
);

initial begin
	$monitor("T= %t | rst_n = %b | en = %b | up_dn = %b | count = %d",
		 $time, rst_n, en, up_dn, count);
end

endmodule
