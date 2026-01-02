module adder_tree #(parameter N=8) (
input clk, E_a, E_b,
input logic [N-1:0] a,b,
output logic [2*N-1:0] P
);

reg [2*N-1:0] A,B;

wire [2*N-1:0] pp [N-1:0];
//gen partial prods
genvar i,j;
generate 
for(i=0; i<N; i=i+1) 
begin
	 assign pp[i] = (A & {N{B[i]}}) << i;
end
endgenerate


//lvl 1
//intermediete sums

wire [2*N-1:0] S [(N-1)>>1:0];


assign S[0] = pp[0] + pp[1];
assign S[1] = pp[2] + pp[3];
assign S[2] = pp[4] + pp[5];
assign S[3] = pp[6] + pp[7];

//lvl 2
//intermediete sums of L2

wire [2*N-1:0] S1 [(N-1)>>2:0];


assign S1[0] = S[0] + S[1];
assign S1[1] = S[2] + S[3];

//lvl 3
//intermediete sums L2

wire [2*N-1:0 ] prod;



assign prod = S1[0] + S1[1];

always@(posedge clk) begin
	if(E_a)
		A <= a;
	if(E_b)
		B <= b;

	P <= prod;
end

endmodule




