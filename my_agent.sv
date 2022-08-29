
import uvm_pkg::*;
import my_test_pkg::*;
//`include "my_tx.sv"
`include "uvm_macros.svh"
//`include "my_driver.sv"
//`include "my_monitor.sv"

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
	//my_coverage_collector cov;
	//my_config m_config;
// configuration knobs

	//localparam OFF=1?b0, ON=1?b1;
	//bit enable_coverage = OFF; // default of disabled
	//uvm_active_passive_enum is_active = UVM_ACTIVE; // default of active
// handles to the monitor's analysis ports
	uvm_analysis_port #(my_tx) dut_inputs_port;
	//uvm_analysis_port #(my_tx) dut_outputs_port;
	
	function void build_phase(uvm_phase phase);

		/*if (uvm_config_db #(my_config)::get(this, "", "test_config", m_config))
			begin // get() succeeded
				this.is_active = this.m_config.is_active;
				this.enable_coverage = this.m_config.enable_coverage;
			end
		else `uvm_warning("LAB", Failed to access config_db -- using defaults instead.\n")*/
			//mon = my_monitor::type_id::create("mon", this);

		//if (is_active == UVM_ACTIVE) 
			//begin
				sequencer = my_sequencer::type_id::create("sequencer", this);
				driver = my_driver::type_id::create("driver", this);
				monitor = my_monitor::type_id::create("monitor", this);
			//end

/*if (enable_coverage)
cov = my_coverage_collector::type_id::create("cov", this);*/
endfunction: build_phase

		function void connect_phase(uvm_phase phase);
			// set agent's analysis ports to point to the monitor's ports
			dut_inputs_port = monitor.dut_inputs_port;
			//dut_outputs_port = mon.dut_outputs_port;
//if (is_active == UVM_ACTIVE) begin
			driver.seq_item_port.connect(sequencer.seq_item_export); // connect driver to sequencer
//end
/*if (enable_coverage)
mon.dut_inputs_port.connect(cov.analysis_export);*/

		endfunction: connect_phase
endclass: my_agent
