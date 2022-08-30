import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_agent;
typedef class my_scoreboard;
typedef class my_coverage;

class my_env extends uvm_env;
	`uvm_component_utils(my_env)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	my_agent agent;
	my_scoreboard scoreboard;
	my_coverage coverage;
	event ok;

	function void build_phase(uvm_phase phase);
		agent = my_agent::type_id::create("agent", this);
		scoreboard = my_scoreboard::type_id::create("scoreboard", this);
		coverage = my_coverage::type_id::create("covergae", this);
		uvm_config_db #(event)::set(null, "*", "ok", ok);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		agent.dut_inputs_port.connect(scoreboard.analysis_export);
		agent.dut_inputs_port.connect(coverage.analysis_export);
	endfunction: connect_phase

	task run_phase(uvm_phase phase);
		coverage.sample();
	endtask: run_phase

endclass: my_env
