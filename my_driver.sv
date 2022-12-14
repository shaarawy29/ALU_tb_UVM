import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_tx;
class my_driver extends uvm_driver #(my_tx);
	`uvm_component_utils(my_driver)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual tb_if tb_vif; // virtual interface pointer

	function void build_phase(uvm_phase phase);
		if (!uvm_config_db #(virtual tb_if)::get(this, "", "DUT_IF", tb_vif))begin
		`uvm_fatal("NOVIF", "Failed to get virtual interface from uvm_config_db.\n")
		end
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		my_tx tx;
		forever begin
			@(posedge tb_vif.clk);// drive values synchronized to interface clock
			seq_item_port.get_next_item(tx); // get a transaction
			tb_vif.A <= tx.A;
			tb_vif.B <= tx.B;
			//tb_vif.ALU_sel <= tx.ALU_sel;
			$display(" T=%0t from the driver ", $time);
			tx.print();
			seq_item_port.item_done();
		end
	endtask: run_phase

endclass: my_driver
