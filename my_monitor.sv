import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_tx;

class my_monitor extends uvm_monitor;
	`uvm_component_utils(my_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual tb_if tb_vif; // virtual interface
	my_tx tx_in;

	uvm_analysis_port #(my_tx) dut_inputs_port; // analysis port for DUT inputs

	function void build_phase(uvm_phase phase);
		dut_inputs_port = new("dut_inputs_port", this); // construct the analysis port
		if (!uvm_config_db #(virtual tb_if)::get(this, "", "DUT_IF", tb_vif))
`			uvm_fatal("NOVIF", "Failed to get virtual interface from uvm_config_db.\n")
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		tx_in = my_tx::type_id::create("tx_in");
		do_monitor();
endtask: run_phase

	task do_monitor();
	forever @(posedge tb_vif.clk) begin
			#2;
		// create a new tx_write object for this cycle
			tx_in.A = tb_vif.A;
			tx_in.B = tb_vif.B;
			tx_in.ALU_sel = tb_vif.ALU_sel;
			tx_in.ALU_out = tb_vif.ALU_out;
    	tx_in.Carry_out = tb_vif.Carry_out;
			$display(" T=%0t from the monitor ", $time);
			tx_in.print();
			dut_inputs_port.write(tx_in);
		end
  endtask

endclass: my_monitor
