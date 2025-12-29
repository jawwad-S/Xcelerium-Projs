module scoreboard #(parameter N=8)(
input logic [N-1:0] count,
input clk, rst_n, en, up_dn
);


reg [N-1:0] expected_cnt;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		expected_cnt <= '0;
	else if(en)
		expected_cnt <= up_dn ? expected_cnt - 1 : expected_cnt + 1;
end


always@(posedge clk) begin
	if(count != expected_cnt)
		$display("T: %t | expected_val: %d | got_val: %d | FAIL",
			 $time, expected_cnt, count);
	else
		$display("T: %t | expected_val: %d | got_val: %d | PASS",
		$time, expected_cnt, count);
end

endmodule   
