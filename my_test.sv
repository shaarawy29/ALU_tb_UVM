import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_env;
typedef class tx_sequence;
class my_test extends uvm_test;

`uvm_component_utils(my_test)

my_env env;
tx_sequence seq;
virtual tb_if dut_if;

function new(string name = "my_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	env = my_env::type_id::create("env", this);
	if (!uvm_config_db #(virtual tb_if)::get(this, "", "DUT_IF", dut_if))
`			uvm_fatal("NOVIF", "Failed to get virtual interface from uvm_config_db.\n")
endfunction

task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq = tx_sequence::type_id::create("seq");
	seq.start(env.agent.sequencer);
	phase.drop_objection(this);
endtask
endclass
