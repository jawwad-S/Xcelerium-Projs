module driver (
input logic clk, g_rst_n, g_en, g_up_dn,
output logic rst_n, en, up_dn
);

always@(posedge clk) begin
rst_n <= g_rst_n;
en <= g_en;
up_dn <= g_up_dn;
end

endmodule
