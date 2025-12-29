module Env #(parameter N=8) (
input clk,
input [N-1:0] count,
output rst_n, en, up_dn
);

//agent
agent #(N) agent_inst  (
.clk(clk),
.count(count),
.rst_n(rst_n),
.en(en),
.up_dn(up_dn)
);

//scoreboard
scoreboard #(N) score_inst (
.clk(clk),
.rst_n(rst_n),
.en(en),
.up_dn(up_dn),
.count(count)
);

endmodule

