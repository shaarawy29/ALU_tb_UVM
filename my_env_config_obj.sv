import uvm_pkg::*;
import my_test_pkg::*;
class my_env_config_obj extends uvm_object;
	`uvm_object_utils(my_env_config_obj)

	function new(string name = "");
		super.new(name);
	endfunction: new

endclass: my_env_config_obj
