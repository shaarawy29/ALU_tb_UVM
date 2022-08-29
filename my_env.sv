
import uvm_pkg::*;
import my_test_pkg::*;

class my_env extends uvm_env;
	`uvm_component_utils(my_env)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	my_agent agent;
	my_scoreboard scoreboard;
	my_coverage covergae;

	function void build_phase(uvm_phase phase);
		agent = my_agent::type_id::create("agent", this);
		scoreboard = my_scoreboard::type_id::create("scoreboard", this);
		covergae = my_covergae::type_id::create("covergae", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		agent.dut_inputs_port.connect(scoreboard.dut_in_imp_export);
		agent.dut_inputs_port.connect(coverage.dut_in_imp_export);
		//agent.dut_outputs_port.connect(scoreboard.dut_out_imp_export);
	endfunction: connect_phase

endclass: my_env
