import uvm_pkg::*;
`include "uvm_macros.svh"
class my_tx extends uvm_sequence_item;
	rand bit [7:0] A;
	rand bit [7:0] B;
	bit[3:0] ALU_sel;
	bit[7:0] ALU_out;
	bit Carry_out;

	//`uvm_object_utils(my_tx)

	`uvm_object_utils_begin(my_tx)
		`uvm_field_int(A, UVM_DEFAULT)
		`uvm_field_int(B, UVM_DEFAULT)
		`uvm_field_int(ALU_sel, UVM_DEFAULT)
		`uvm_field_int(ALU_out, UVM_DEFAULT)
		`uvm_field_int(Carry_out, UVM_DEFAULT)
	`uvm_object_utils_end

	function new(string name = "my_tx");
		super.new(name);
	endfunction

endclass: my_tx
