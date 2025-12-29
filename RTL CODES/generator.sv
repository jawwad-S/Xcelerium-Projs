module generator(
input clk,
output logic g_rst_n = 0, g_en, g_up_dn
);

//reg g_rst_n, g_en, g_up_dn;

reg [3:0] cycle = 0;

always @(posedge clk) begin

        cycle <= cycle + 1;
	if(cycle < 1)
		g_rst_n <= 0;
	else
		g_rst_n <= 1;

        if (cycle < 3) begin
            g_en <= 1;
            g_up_dn <= 1; // counting up
        end else if (cycle < 6) begin
            g_en <= 1;
            g_up_dn <= 0; // counting down
        end else begin
            g_en <= $random;
            g_up_dn <= $random % 2; 
        end
    end





endmodule





