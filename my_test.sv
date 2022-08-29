import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_env;
typedef class tx_sequence;
//typedef class my_sequencer;
class my_test extends uvm_test;

`uvm_component_utils(my_test)

my_env env;
tx_sequence seq;
//my_env_config_obj m_env_cfg;

function new(string name = "my_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	//m_env_cfg = my_env_config_obj::type_id::create("m_env_cfg");
	env = my_env::type_id::create("env", this);
	//if(!uvm_config_db#(virtual my_dut_interface)::get(this, "" ,"DUT_IF",
	//m_env_cfg.dut_if))
		//`uvm_error("TEST", "Failed to get virtual interface in test")
	// set other aspects of m_env_cfg
	//uvm_config_db#(my_env_config_obj)::set(this, "my_env", "m_env_cfg", m_env_cfg);
endfunction

task run_phase(uvm_phase phase);
	phase.raise_objection(this);
  //optionally randomize sequence
	//assert(seq.randomize() with {src_addr == 32?h0100_0800;xfer_size == 128;});
	seq = tx_sequence::type_id::create("seq");
	seq.start(env.agent.sequencer);
	phase.drop_objection(this);
endtask
endclass
