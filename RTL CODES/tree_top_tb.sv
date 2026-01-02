`include "adder_tree_classes.sv"
import adder_tree_classes_pkg::*;

interface tree_inf #(parameter N = 8);
logic clk, E_a, E_b;
logic [N-1:0] a,b;
logic [2*N-1:0] P;
endinterface

module adder_tree_top_tb;
    parameter N = 8;


tree_inf #(N) tif();

//DUT
adder_tree #(N) dut(
.clk(tif.clk),
.E_a(tif.E_a),
.E_b(tif.E_b),
.a(tif.a),
.b(tif.b),
.P(tif.P)
);

//Clk GENERATION
always
#10 tif.clk = ~tif.clk;
    // Interface of DUT
    //shift_inf #(N) sif();

    // Mailboxes
    mailbox #(tree_trans #(N)) gen_mb = new();
    mailbox #(tree_trans #(N)) gen_sb = new();
    mailbox #(tree_trans #(N)) mon_mb = new();

    // Class declaring
    tree_gen #(N) generator;
    tree_driver driver;
    monitor mon;
    scoreboard #(N) sb;
initial begin
    //clk initialization
    tif.clk = 0;


    //Classes instances
    generator = new(gen_mb, gen_sb);
    driver = new(tif, gen_mb);
    mon = new(tif, mon_mb);
    sb = new(gen_sb, mon_mb);


   
        fork

           /* forever generator.gen();
            driver.drive();
            mon.monitor();
            sb.scoreboard();*/

		 forever generator.gen();
        	 driver.drive();
 		 mon.monitor();
		 forever sb.scoreboard();

 /*       forever begin
            shift_trans #(N) exp, act;
            m_exp.get(exp);
            m_act.get(act);
            if(exp.q_out != act.q_out)
                $display("MISMATCH exp=%b act=%b | FAIL", exp.q_out, act.q_out);
            else
                $display("MATCH exp=%b act=%b | PASS", exp.q_out, act.q_out);
        end
*/
        join_none
#1000;
$finish;
    end
endmodule

