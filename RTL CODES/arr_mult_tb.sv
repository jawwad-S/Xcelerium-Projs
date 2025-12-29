//`timescale 1ns/1ps

module arr_tb;

  parameter n = 8;

  logic clk;
  logic E_a, E_b;
  logic [n-1:0] a, b;
  logic [2*n-1:0] P;

  // DUT
  arr #(n) dut (
    .clk(clk),
    .E_a(E_a),
    .E_b(E_b),
    .a(a),
    .b(b),
    .P(P)
  );

  // clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    E_a = 0;
    E_b = 0;
    a   = 0;
    b   = 0;

    // wait a bit
    #20;

    // -------- TEST CASES --------
    run_test(8'd3,  8'd7);
    run_test(8'd12, 8'd9);
    run_test(8'd25, 8'd4);
    run_test(8'd15, 8'd15);
    run_test(8'd255,8'd2);
    run_test(8'd128,8'd128);

    // random tests
    repeat (10) begin
      run_test($urandom_range(0,255), $urandom_range(0,255));
    end

    $display("ALL TESTS COMPLETED");
    $stop;
  end

  // ----------------------------
  // TASK: run one multiplication
  // ----------------------------
  task run_test(input [n-1:0] ta, input [n-1:0] tb);
    reg [2*n-1:0] expected;
    begin
      // load A and B
      @(posedge clk);
      E_a = 1;
      E_b = 1;
      a   = ta;
      b   = tb;

      @(posedge clk);  // latch inputs
      E_a = 0;
      E_b = 0;


      expected = ta * tb;

      if (P === expected)
        $display("PASS: A=%0d B=%0d P=%0d", ta, tb, P);
      else
        $display("FAIL: A=%0d B=%0d P=%0d expected=%0d",
                 ta, tb, P, expected);
    end
  endtask

endmodule

