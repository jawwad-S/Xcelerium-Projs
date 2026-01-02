
`include "arr_mult_class.sv"
import arr_mult_classes_pkg::*;

interface arr_inf #(parameter N = 8);
logic clk, E_a, E_b;
logic [N-1:0] a,b;
logic [2*N-1:0] P;
endinterface

module arr_mult_top_tb;
    parameter N = 8;


arr_inf #(N) aif();

//DUT
arr #(N) dut(
.clk(aif.clk),
.E_a(aif.E_a),
.E_b(aif.E_b),
.a(aif.a),
.b(aif.b),
.P(aif.P)
);

//Clk GENERATION
always
#10 aif.clk = ~aif.clk;
        //shift_inf #(N) sif();

    // mailboxes 
    mailbox #(arr_trans #(N)) gen_mb = new();
    mailbox #(arr_trans #(N)) gen_sb = new();
    mailbox #(arr_trans #(N)) mon_mb = new();

    // Class declaring
    arr_gen #(N) generator;
    arr_driver driver;
    monitor mon;
    scoreboard #(N) sb;
initial begin
    
    aif.clk = 0;


    //Classes instances
    generator = new(gen_mb, gen_sb);
    driver = new(aif, gen_mb);
    mon = new(aif, mon_mb);
    sb = new(gen_sb, mon_mb);


   
        fork

           /* forever generator.gen();
            driver.drive();
            mon.monitor();
            sb.scoreboard();*/
	for(int i=0; i<10; i=i+1)
		 generator.gen();
        	 driver.drive();
 		 mon.monitor();
	for(int i=0; i<10; i=i+1)
		 sb.scoreboard();

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
