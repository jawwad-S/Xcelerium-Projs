module barrel_shifter_tb;

    logic        dir;
    logic [31:0] data;
    logic [4:0]  shift_amt;
    logic [31:0] out;

    logic [31:0] expected_out;
    integer errors = 0;

    
    barrel_shifter dut (
        .dir(dir),
        .data(data),
        .shift_amt(shift_amt),
        .out(out)
    );


    task result_check;
        begin
            if (out !== expected_out) begin
               $display("data : %d out: %d expected result: %d dir: %b shift: %b| Test: FAIL", data, out, expected_out, dir, shift_amt);
                errors = errors + 1;
            end else begin
                $display("data : %d out: %d expected result: %d dir: %b shift: %b| Test: PASS", data, out, expected_out, dir, shift_amt);

                        
            end
        end
    endtask


    initial begin

        
        $display("////// Directed TESTS ///////");

        // Left shift
        dir = 0; data = 32'd30000; shift_amt = 1;
        expected_out = data << shift_amt;
        #1 result_check;

        // Right shift
        dir = 1; data = 32'd30000; shift_amt = 1;
        expected_out = data >> shift_amt;
        #1 result_check;

        // Edge cases
        dir = 0; data = 32'hFFFFFFFF; shift_amt = 1;
        expected_out = data << shift_amt;
        #1 result_check;

        dir = 1; data = 32'h00000001; shift_amt = 1;
        expected_out = data >> shift_amt;
        #1 result_check;

        
        $display("//// RANDOM TESTS ////");

        for (int i = 0; i < 10; i++) begin
            dir       = $random ;
            data      = $random;
            shift_amt = $random ;

            if (dir == 0)
                expected_out = data << shift_amt;
            else
                expected_out = data >> shift_amt;

            #1 result_check;
        end

      
        if (errors == 0)
            $display("ALL TESTS PASSED ");
        else
            $display("%0d TESTS FAILED ", errors);

        $finish;
    end

endmodule

