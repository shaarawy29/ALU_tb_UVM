import uvm_pkg::*;
import my_test_pkg::*;

class my_test extends uvm_test;
`uvm_component_utils(my_test)

my_env m_env;
my_env_config_obj m_env_cfg;

function new(string name = "my_test", uvm_component parent = null);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	m_env_cfg = my_env_config_obj::type_id::create("m_env_cfg");
	m_env = my_env::type_id::create("my_env", this);
	if(!uvm_config_db#(virtual my_dut_interface)::get(this, "" ,"DUT_IF",
	m_env_cfg.dut_if))
`		uvm_error("TEST", "Failed to get virtual interface in test")
	// set other aspects of m_env_cfg
	uvm_config_db#(my_env_config_obj)::set(this, "my_env", "m_env_cfg", m_env_cfg);
endfunction

task run_phase(uvm_phase phase);
	phase.raise_objection("Starting test");
	my_seq seq = my_seq::type_id::create("seq");
  //optionally randomize sequence
	//assert(seq.randomize() with {src_addr == 32?h0100_0800;xfer_size == 128;});
	seq.start(m_env.m_agent.m_sequencer);
	phase.drop_objection("Ending test");
endtask
endclass
