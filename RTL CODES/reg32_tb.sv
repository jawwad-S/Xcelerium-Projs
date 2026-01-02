module reg32_tb;

logic clk=0, rst_n, load;
logic [31:0]d;
logic [31:0]q;

reg32 dut(
.clk(clk),
.rst_n(rst_n),
.load(load),
.d(d),
.q(q)
);

//clk gen
always
#10 clk = !clk;

initial begin
rst_n = 1'b0;
load = 1'b0;
d = 32'd0;

end


initial begin
#10 rst_n = 1;
load = 1;
d = 32'h4;
#10
d = 32'hF4;
#10
load = 0;
d =  32'hA4;
#50
$finish;
end


//rst
assert property (@(posedge clk)
(!rst_n |-> q == 32'd0)
)else $error("Reset assertion failed at time %0t", $time);


//load
assert property (@(posedge clk)
(load |-> q == d)
)else $error("Load assertion failed at time %0t", $time);

//hold
assert property (@(posedge clk)
(!load |-> q == $past(q))
)else $error("Hold assertion failed at time %0t", $time);

endmodule
