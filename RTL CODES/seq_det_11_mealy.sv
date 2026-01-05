module seq_det_11_mealy(
input logic clk, rst, in,
output logic z
);

reg state = 1'b0;

localparam S0 = 1'b0, S1 = 1'b1;

always@(posedge clk or posedge rst) 
begin

if(rst) begin
state <= 1'b0;
end

else begin
case(state)

S0: begin
if(in == 1'b1)
state <= S1;
else 
state <= S0;
end

S1: begin
if(in == 1'b0)
state <= S0;
else 
state <= S1;
end
endcase

end	//else
end	//always

always@(*) begin
case(state)
S0: z = 1'b0;
S1: begin
if(in == 1'b1)
z = 1'b1;
else
z = 1'b0;
end
endcase
end



endmodule


