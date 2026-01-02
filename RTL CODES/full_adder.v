module FA (a,b, cin,s,co);
input a,b;
input cin;
output s;
output co;

assign {co, s} = a + b + cin;

endmodule
