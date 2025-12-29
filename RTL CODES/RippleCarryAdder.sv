module RPA #(parameter n = 8)(
input logic [n-1:0] A, B,
input Cin,
output logic [n-1:0] S,
output Co
);

wire [n:0] carry; //intermediete wires foor carry
assign carry[0] = Cin;
assign Co = carry[n];

genvar i;

generate 
	for(i = 0; i < n; i = i+1) begin
		FA fa_inst  (
			.a(A[i]), .b(B[i]), .cin(carry[i]), .s(S[i]), .co(carry[i+1])
			);
	end
endgenerate 

endmodule
