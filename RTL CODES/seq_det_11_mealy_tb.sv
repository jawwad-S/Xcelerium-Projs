module seq_det_11_mealy_tb;

logic clk, rst, in, z;

seq_det_11_mealy dut (
.clk(clk),
.rst(rst),
.in(in),
.z(z)
);


initial
clk = 0;

always
#10 clk = ~clk;

initial begin
rst = 1;
in = 0;
#10
rst = 0;
in = 0;
#20
in = 1;
#20
in = 0;
#20
in = 1;
#20
in = 1;
#20
in = 0;

#150 $finish;
end

endmodule
