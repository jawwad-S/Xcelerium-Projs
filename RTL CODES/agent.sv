module agent #(parameter N=8)(
input clk,
output rst_n, en, up_dn,
input logic [N-1:0] count
);

wire g_rst_n, g_en, g_up_dn;

//generator
generator gen_inst(
.clk(clk),
.g_rst_n(g_rst_n),
.g_en(g_en),
.g_up_dn(g_up_dn)
);


//driver 
driver driver_inst(
.clk(clk),
.g_rst_n(g_rst_n),
.g_en(g_en),
.g_up_dn(g_up_dn),
.rst_n(rst_n),
.en(en),
.up_dn(up_dn)
);

//monitor
monitor #(N) mont_inst(
.rst_n(rst_n),
.en(en),
.up_dn(up_dn),
.count(count)
);

endmodule




