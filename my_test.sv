import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_env;
typedef class tx_sequence;
class my_test extends uvm_test;

`uvm_component_utils(my_test)

my_env env;
tx_sequence seq;

function new(string name = "my_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	env = my_env::type_id::create("env", this);
endfunction

task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq = tx_sequence::type_id::create("seq");
	seq.start(env.agent.sequencer);
	phase.drop_objection(this);
endtask
endclass
