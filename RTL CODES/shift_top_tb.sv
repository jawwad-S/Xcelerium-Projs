`include "shift_classes.sv"
import shift_classes_pkg::*;

interface shift_inf #(parameter N = 8);
logic clk, rst_n, shift_en, dir, din;
logic [N-1:0] q_out;
endinterface

module shift_top_tb;
    parameter N = 8;

//DUT
shift_reg #(N) dut(
.clk(sif.clk),
.rst_n(sif.rst_n),
.shift_en(sif.shift_en),
.dir(sif.dir),
.din(sif.din),
.q_out(sif.q_out)
);

//Clk GENERATION
always
#10 sif.clk = ~sif.clk;
    // Interface of DUT
    shift_inf #(N) sif();

    // Mailboxes
    mailbox #(shift_trans #(N)) gen_mb = new();
    mailbox #(shift_trans #(N)) gen_sb = new();
    mailbox #(shift_trans #(N)) mon_mb = new();

    // Class declaring
    shift_gen #(N) generator;
    shift_driver driver;
    monitor mon;
    scoreboard #(N) sb;
initial begin
    //clk initialization
    sif.clk = 0;
    sif.rst_n = 0;
  #10 sif.rst_n = 1;

    //Classes instances
    generator = new(gen_mb, gen_sb);
    driver = new(sif, gen_mb);
    mon = new(sif, mon_mb);
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
#200;
$finish;
    end
endmodule

