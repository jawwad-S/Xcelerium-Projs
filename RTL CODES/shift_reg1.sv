module shift_reg #(parameter N = 8)(
input clk, rst_n, shift_en, dir, din,
output logic [N-1:0] q_out
);

always@(posedge clk or negedge rst_n) begin
if(!rst_n)
q_out <= {N{1'b0}};
else  if(shift_en)
q_out <= dir ? {din, q_out[N-1:1]} : {q_out[N-2:0],din};
else
q_out <= q_out;
end


endmodule

