import uvm_pkg::*;
`include "uvm_macros.svh"
//import my_test_pkg::*;
class my_tx extends uvm_sequence_item;
	rand bit [7:0] A;
	rand bit [7:0] B;
	bit[3:0] ALU_sel;
	bit[7:0] ALU_out;
	bit Carry_out;

	`uvm_object_utils(my_tx)

	function new(string name = "my_tx");
		super.new(name);
	endfunction

	/*virtual function void do_copy(uvm_object rhs);
			... // implementation not shown
	endfunction

virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
... // implementation not shown
endfunction*/

endclass: my_tx
