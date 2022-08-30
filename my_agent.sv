
import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"

typedef class my_tx;
typedef class my_driver;
typedef class my_monitor;
typedef class my_sequencer;

class my_agent extends uvm_agent;
	`uvm_component_utils(my_agent) // register this class in the factory

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
// handles for agent?s components
	my_sequencer sequencer;
	my_driver driver;
	my_monitor monitor;
	uvm_analysis_port #(my_tx) dut_inputs_port;
	
	function void build_phase(uvm_phase phase);
				sequencer = my_sequencer::type_id::create("sequencer", this);
				driver = my_driver::type_id::create("driver", this);
				monitor = my_monitor::type_id::create("monitor", this);
endfunction: build_phase

		function void connect_phase(uvm_phase phase);
			dut_inputs_port = monitor.dut_inputs_port;
			driver.seq_item_port.connect(sequencer.seq_item_export); // connect driver to sequencer
		endfunction: connect_phase
endclass: my_agent
