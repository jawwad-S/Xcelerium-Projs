package adder_tree_classes_pkg;


class tree_trans #(parameter N=8);

rand bit E_a;
rand bit E_b;
rand bit [N-1:0] a,b;
bit [2*N-1:0] P;

function new(); endfunction

endclass
 

class tree_gen #(parameter N=8);

tree_trans #(N) t;
mailbox #(tree_trans) mb1;
mailbox #(tree_trans) mb_exp;

function new(mailbox #(tree_trans #(N)) mb1, mailbox #(tree_trans) mb_exp);
this.mb1 = mb1;
this.mb_exp = mb_exp;
t = new();
endfunction



task gen ();
//assert(t.randomize())
//$urandom(t);
tree_trans tx;
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


class tree_driver;
virtual tree_inf vinf;

mailbox #(tree_trans) mb2;


function new(virtual tree_inf vinf, mailbox #(tree_trans) mb2);
this.vinf = vinf;
this.mb2 = mb2;
endfunction

task drive ();
forever begin
tree_trans trans;
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

virtual tree_inf vinf;
mailbox #(tree_trans) mb3;

function new(virtual tree_inf vinf, mailbox #(tree_trans) mb3);
this.vinf = vinf;
this.mb3 = mb3;
endfunction


task monitor ();
forever@(posedge vinf.clk)
begin
tree_trans tm;
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


mailbox #(tree_trans #(N)) m_exp;
mailbox #(tree_trans #(N)) m_act;


function new(mailbox #(tree_trans #(N)) mb_exp,mailbox #(tree_trans #(N)) m_act);
this.m_exp = mb_exp;
this.m_act = m_act;
ref_P = '0;
endfunction

task scoreboard();
forever begin
tree_trans #(N) exp, act;
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

