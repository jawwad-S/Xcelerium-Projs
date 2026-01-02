package arr_mult_classes_pkg;


class arr_trans #(parameter N=8);

rand bit E_a;
rand bit E_b;
rand bit [N-1:0] a,b;
bit [2*N-1:0] P;

function new(); endfunction

endclass
 

class arr_gen #(parameter N=8);

arr_trans #(N) t;
mailbox #(arr_trans) mb1;
mailbox #(arr_trans) mb_exp;

function new(mailbox #(arr_trans #(N)) mb1, mailbox #(arr_trans) mb_exp);
this.mb1 = mb1;
this.mb_exp = mb_exp;
t = new();
endfunction



task gen ();
//assert(t.randomize())
//$urandom(t);
arr_trans tx;
tx = new();
tx.E_a = $urandom_range(0,1);
tx.E_b = $urandom_range(0,1);
tx.a      = $urandom_range(0,2**N-1);
tx.b      = $urandom_range(0,2**N-1);



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


class arr_driver;
virtual arr_inf vinf;

mailbox #(arr_trans) mb2;


function new(virtual arr_inf vinf, mailbox #(arr_trans) mb2);
this.vinf = vinf;
this.mb2 = mb2;
endfunction

task drive ();
forever begin
arr_trans trans;
mb2.get(trans);
vinf.E_a <= trans.E_a;
vinf.E_b <= trans.E_b;
vinf.a <= trans.a;
vinf.b <= trans.b;
//vinf.rst_n = trans.rst_n;
@(posedge vinf.clk);
vinf.E_a <= 0; vinf.E_b <= 0;
end
endtask

endclass

class monitor;

virtual arr_inf vinf;
mailbox #(arr_trans) mb3;

function new(virtual arr_inf vinf, mailbox #(arr_trans) mb3);
this.vinf = vinf;
this.mb3 = mb3;
endfunction


task monitor ();
forever@(posedge vinf.clk)
begin
arr_trans tm;
tm = new();
tm.E_a = vinf.E_a;
tm.E_b = vinf.E_b;
tm.a = vinf.a;
tm.b = vinf.b;
tm.P= vinf.P;
mb3.put(tm);

$display("a: %d | b: %d | Prod: %d", vinf.a, vinf.b, vinf.P);
end



endtask

endclass

class scoreboard #(parameter N=8);
bit [2*N-1:0] ref_P;


mailbox #(arr_trans #(N)) m_exp;
mailbox #(arr_trans #(N)) m_act;


function new(mailbox #(arr_trans #(N)) mb_exp,mailbox #(arr_trans #(N)) m_act);
this.m_exp = mb_exp;
this.m_act = m_act;
ref_P = '0;
endfunction

task scoreboard();
forever begin
arr_trans #(N) exp, act;
m_exp.get(exp);
m_act.get(act);



ref_P = exp.a * exp.b;

if(ref_P != act.P)
$display("MISMATCH exp=%d act=%d | FAIL", ref_P, act.P);
else
$display("MATCH exp=%d act=%d | PASS", ref_P, act.P);

end
endtask

endclass



endpackage
