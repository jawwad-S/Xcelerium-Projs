module arr #(parameter n = 8)(
input clk, E_a, E_b,
input logic [n-1:0] a, b,
output logic [2*n-1:0] P
);


reg [n-1:0] A, B;

wire [n-1:0] s0; //intermediete sums
wire [n-1:0] s1; //intermediete sums
wire [n-1:0] s2; //intermediete sums
wire [n-1:0] s3; //intermediete sums
wire [n-1:0] s4; //intermediete sums
wire [n-1:0] s5; //intermediete sums
wire [n-1:0] s6; //intermediete sums

wire [n-2:0] c; //intermediete carries


wire [n-1:0] p0;
wire [n-1:0] p1;
wire [n-1:0] p2;
wire [n-1:0] p3;
wire [n-1:0] p4;
wire [n-1:0] p5;
wire [n-1:0] p6;
wire [n-1:0] p7;


wire [2*n-1:0] P_comb;

always@(posedge clk) begin
if(E_a )
A <= a;
if(E_b)
B <= b;

//P <= P_comb;
end


genvar i;

//first row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r1
		assign p0[i] = A[i] & B[0];
	end
endgenerate


//2nd row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r2
		assign p1[i] = A[i] & B[1];
	end
endgenerate

//RPA INSTANTIATION_1

RPA rpa1 (.A({1'b0,p0[n-1:1]}), .B(p1), .Cin(1'b0), .S(s0), .Co(c[0]));


//3rd row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r3
		assign p2[i] = A[i] & B[2];
	end
endgenerate

//RPA INSTANTIATION_2

RPA rpa2 (.A({c[0],s0[n-1:1]}), .B(p2), .Cin(1'b0), .S(s1), .Co(c[1]));


//4rd row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r4
		assign p3[i] = A[i] & B[3];
	end
endgenerate

//RPA INSTANTIATION_3

RPA rpa3 (.A({c[1],s1[n-1:1]}), .B(p3), .Cin(1'b0), .S(s2), .Co(c[2]));


//5th row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r5
		assign p4[i] = A[i] & B[4];
	end
endgenerate

//RPA INSTANTIATION_4

RPA rpa4 (.A({c[2],s2[n-1:1]}), .B(p4), .Cin(1'b0), .S(s3), .Co(c[3]));


//6th row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r6
		assign p5[i] = A[i] & B[5];
	end
endgenerate

//RPA INSTANTIATION_5

RPA rpa5 (.A({c[3],s3[n-1:1]}), .B(p5), .Cin(1'b0), .S(s4), .Co(c[4]));


//7th row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r7
		assign p6[i] = A[i] & B[6];
	end
endgenerate

//RPA INSTANTIATION_6

RPA rpa6 (.A({c[4],s4[n-1:1]}), .B(p6), .Cin(1'b0), .S(s5), .Co(c[5]));


//8th row logic
generate 
	for (i = 0; i < n; i = i+1) begin: and_r8
		assign p7[i] = A[i] & B[7];
	end
endgenerate

//RPA INSTANTIATION_7

RPA rpa7 (.A({c[5],s5[n-1:1]}), .B(p7), .Cin(1'b0), .S(s6), .Co(c[6]));


assign P_comb[0]  = p0[0];
assign P_comb[1]  = s0[0];
assign P_comb[2]  = s1[0];
assign P_comb[3]  = s2[0];
assign P_comb[4]  = s3[0];
assign P_comb[5]  = s4[0];
assign P_comb[6]  = s5[0];
assign P_comb[7]  = s6[0];
assign P_comb[8]  = s6[1];
assign P_comb[9]  = s6[2];
assign P_comb[10] = s6[3];
assign P_comb[11] = s6[4];
assign P_comb[12] = s6[5];
assign P_comb[13] = s6[6];
assign P_comb[14] = s6[7];
assign P_comb[15] = c[6];



always@(posedge clk)
P <= P_comb;

endmodule










