package shift_classes_pkg;


class shift_trans #(parameter N=8);

rand bit shift_en;
rand bit dir;
rand bit din;
bit [N-1:0] q_out;
bit rst_n;

function new(); endfunction

endclass


class shift_gen #(parameter N=8);

shift_trans #(N) t;
mailbox #(shift_trans) mb1;
mailbox #(shift_trans) mb_exp;

function new(mailbox #(shift_trans #(N)) mb1, mailbox #(shift_trans) mb_exp);
this.mb1 = mb1;
this.mb_exp = mb_exp;
t = new();
endfunction



task gen ();
//assert(t.randomize())
//$urandom(t);
shift_trans tx;
tx = new();
tx.shift_en = $urandom_range(0,1);
tx.dir      = $urandom_range(0,1);
tx.din      = $urandom_range(0,1);
//tx.rst_n    = 1;

//else $error("Randomization Failed");

/*if(!tx.rst_n)
tx.q_out = '0;
else if(tx.shift_en) begin
tx.q_out = tx.dir ? {tx.din, tx.q_out[N-1:1]} : {tx.q_out[N-2:0],tx.din};
end*/
		
mb1.put(tx);
mb_exp.put(tx);


endtask


endclass


class shift_driver;
virtual shift_inf vinf;

mailbox #(shift_trans) mb2;


function new(virtual shift_inf vinf, mailbox #(shift_trans) mb2);
this.vinf = vinf;
this.mb2 = mb2;
endfunction

task drive ();
forever begin
shift_trans trans;
mb2.get(trans);
vinf.shift_en = trans.shift_en;
vinf.din = trans.din;
vinf.dir = trans.dir;
//vinf.rst_n = trans.rst_n;
@(posedge vinf.clk);
end
endtask

endclass

class monitor;

virtual shift_inf vinf;
mailbox #(shift_trans) mb3;

function new(virtual shift_inf vinf, mailbox #(shift_trans) mb3);
this.vinf = vinf;
this.mb3 = mb3;
endfunction


task monitor ();
forever@(posedge vinf.clk)
begin
shift_trans t;
t = new();
t.shift_en = vinf.shift_en;
t.dir = vinf.dir;
t.din = vinf.din;
t.q_out= vinf.q_out;
mb3.put(t);

$display("din: %b | dir: %b | output: %b", vinf.din, vinf.dir, vinf.q_out);
end



endtask

endclass

class scoreboard #(parameter N=8);
bit [N-1:0] ref_q;


mailbox #(shift_trans #(N)) m_exp;
mailbox #(shift_trans #(N)) m_act;


function new(mailbox #(shift_trans #(N)) mb_exp,mailbox #(shift_trans #(N)) m_act);
this.m_exp = mb_exp;
this.m_act = m_act;
ref_q = '0;
endfunction

task scoreboard();
shift_trans #(N) exp, act;
m_exp.get(exp);
m_act.get(act);



if(!exp.rst_n)
ref_q = '0;
else if(exp.shift_en)
  ref_q = (exp.dir) ? {exp.din,ref_q[N-1:1]} : {ref_q[N-2:0],exp.din};
else
ref_q = ref_q;

if(ref_q != act.q_out)
$display("MISMATCH exp=%b act=%b | FAIL", ref_q, act.q_out);
else
$display("MATCH exp=%b act=%b | PASS", ref_q, act.q_out);


endtask

endclass



endpackage


