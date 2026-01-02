module seq_det_11_moore(
input logic clk, rst, in,
output logic q
);


logic [1:0] state;

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always_ff@(posedge clk or posedge rst)
begin

if(rst)
state <= S0;

else begin

case(state)
S0: begin
if(in == 1'b1)
state <= S1;
else 
state <= S0;
end

S1: begin
if(in == 1'b1)
state <= S2;
else 
state <= S0;
end

S2: begin
if(in == 1'b1)
state <= S2;
else
state <= S0;
end

endcase
end
end //always

always@(*) begin
if(state == S2)
q = 1'b1;

else
q = 0;
end
endmodule
