import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
class test_6 extends my_test;

`uvm_component_utils(test_6)

function new(string name = "test_6", uvm_component parent = null);
	super.new(name, parent);
endfunction

task run_phase(uvm_phase phase);
	fork begin
	super.run_phase(phase);
	end
	begin
		dut_if.ALU_sel = 4'h6;
	end
join_any
endtask
endclass
