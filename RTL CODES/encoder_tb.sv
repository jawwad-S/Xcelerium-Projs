module encoder_tb;

logic [7:0] in;
logic [2:0] out;

encoder_8x3 inst (
.in(in),
.out(out)
);

logic [2:0] expected_result;
integer errors = 0;

	task result_check;
	  begin

		if(^in == 1'b0)
			$display("in : %b out: %b expected result: %b \n INVALID Pattern Detected", in, out, expected_result);

            	if (out != expected_result) begin
                	$display("in : %b out: %b expected result: %b | Test: FAIL", in, out, expected_result);
			errors = errors + 1;
	    	end 

	    	else begin
			$display("in : %b out: %b expected result: %b | Test: PASS",in, out, expected_result);
		end
	  end
	endtask

initial begin
	for (int i = 0; i < 10; i = i + 1) begin
            	in = $random;	
		casez(in)
		8'b1???????: expected_result = 3'd7;
		8'b01??????: expected_result = 3'd6;
		8'b001?????: expected_result = 3'd5;
		8'b0001????: expected_result = 3'd4;
		8'b00001???: expected_result = 3'd3;
		8'b000001??: expected_result = 3'd2;
		8'b0000001?: expected_result = 3'd1;
		8'b00000001: expected_result = 3'd0;
		default: out = 3'd0;
		endcase
	    	#1 result_check;
        end	



//VALID PATTERNS
for(int j = 0; j < 8; j=j+1) begin
	in = 8'b1 << j;
	expected_result = j;
	#1 result_check;
end

//INVALID PATTERNS

/*for(int k = 0; k < 8; k=k+1) begin
	in_tmp = 8'b1 << k;
	in = in_tmp + 1;
	expected_result = k+1;
	#1 result_check;
end*/
for (int i = 0; i < 7; i = i + 1) begin
    for (int j = i+1; j < 8; j = j + 1) begin
        in = (8'b1 << i) | (8'b1 << j); // two bits set
        expected_result = j;             // MSB takes priority
        #1 result_check;
    end
end

        if (errors == 0)
            $display("All tests passed!");
        else
            $display("%0d tests failed.", errors);


$finish;
end
endmodule

