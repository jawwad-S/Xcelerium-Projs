module tst_top;

parameter N=8;

logic clk, rst_n, en, up_dn;
logic [N-1:0] count;


//clk gen
initial begin
clk = 0;
#500 $finish;
end

always
#10 clk = ~clk;


//dut
counter #(N) cnt_inst_top (
.clk(clk), .rst_n(rst_n), .en(en), .up_dn(up_dn), .count(count)
);

//env
Env #(N) env_inst (
.clk(clk),
.rst_n(rst_n),
.en(en),
.up_dn(up_dn),
.count(count)
);

endmodule
