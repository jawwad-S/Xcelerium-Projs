`timescale 1ns/1ps

module adder_tb;
    
    logic [31:0] a, b;
    logic cin;
    logic [31:0] sum;
    logic co, OF;

   
    adder uut (
        .a(a),
        .b(b),
	.cin(cin),
        .sum(sum),
	.co(co),
	.OF(OF)
    );

    logic [31:0] expected_sum;
    logic expected_OF;

   
    integer errors = 0;

	task result_check;
	  begin
            	if ((sum != expected_sum) || (OF != expected_OF)) begin
                	//$display("Mismatch! a=%0d b=%0d expected=%0d got=%0d", a, b, expected_sum, sum);
			$display("a: %h	b: %h result: %h expected result: %h | Test: FAIL", a,b,sum, expected_sum);
			$display("OverFlow: %h Expected OverFlow: %h | OverFlow Test: FAIL", OF, expected_OF);
			errors = errors + 1;
	    	end 

	    	else begin
			$display("a: %h	b: %h result: %h expected result: %h | Test: PASS", a,b,sum,expected_sum);
			$display("OverFlow: %h Expected OverFlow: %h | OverFlow Test: PASS", OF, expected_OF);
		    end
	  end
	endtask

    initial begin
        for (int i = 0; i < 10; i = i + 1) begin
            a = $random;
            b = $random;
	    cin = $random & 1;
            expected_sum = a + b + cin;
	    expected_OF = ((a[31] & b[31] & ~expected_sum[31]) | (~a[31] & ~b[31] & expected_sum[31]));
	     #1;
	    result_check;
        end	//for

///// EDGE CASES /////

// 0 + 0
a = 32'h0; b = 32'h0; cin = 1'b0;
expected_sum = a + b + cin;
expected_OF = ((a[31] & b[31] & ~expected_sum[31]) | (~a[31] & ~b[31] & expected_sum[31]));
#1 result_check;

//32'F +32'F
a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; cin = 1'b0;
expected_sum = a + b + cin;
expected_OF = ((a[31] & b[31] & ~expected_sum[31]) | (~a[31] & ~b[31] & expected_sum[31]));
#1 result_check;

//32'7F + 1
a = 32'h7FFFFFFF; b = 32'h00000001; cin = 1'b0;
expected_sum = a + b + cin;
expected_OF = ((a[31] & b[31] & ~expected_sum[31]) | (~a[31] & ~b[31] & expected_sum[31]));
#1 result_check;

//32'80000000 + 32'h80000000
a = 32'h80000000; b = 32'h80000000; cin = 1'b0;
expected_sum = a + b + cin;
expected_OF = ((a[31] & b[31] & ~expected_sum[31]) | (~a[31] & ~b[31] & expected_sum[31]));
#1 result_check;


        if (errors == 0)
            $display("All tests passed!");
        else
            $display("%0d tests failed.", errors);

        $finish;
    end

endmodule

