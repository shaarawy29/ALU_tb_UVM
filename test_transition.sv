import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
class test_transition extends my_test;

`uvm_component_utils(test_transition)

function new(string name = "test_transition", uvm_component parent = null);
	super.new(name, parent);
endfunction

task run_phase(uvm_phase phase);
	fork begin
	super.run_phase(phase);
	end
	begin
		dut_if.ALU_sel = 4'h0;
    #20;
    dut_if.ALU_sel = 4'h1;
    #20;
    dut_if.ALU_sel = 4'h2;
    #20;
	end
join_any
#5 $finish;
endtask
endclass
