
class my_coverage extends uvm_subscriber #(my_tx);
	my_tx tx; // the transaction object on which value changes will be covered

	covergroup functional_cov;

		third_input_2: coverpoint m_ALU_if.ALU_sel { 
									option.at_least = 4;
									option.weight = 16;
									bins instructions[16] = {[0:15]} ;
                 }
		transition: coverpoint m_ALU_if.ALU_sel {
									option.weight = 1;
									bins t = (4'h0 => 4'h1 => 4'h2);
		}
	endgroup

`	uvm_component_utils(my_coverage_collector)

	function new(string name, uvm_component parent );
		super.new(name, parent);
		functional_cov = new(); // construct the covergroup
	endfunction: new
	
	function void write(my_tx t);
		tx = t; // copy transaction handle received from the monitor
		functional_cov.sample();//will be changed later
	endfunction: write

	function void report_phase(uvm_phase phase);
		`uvm_info("DEBUG", $sformatf("\n\n Coverage for instance %s = %2.2f%%\n\n",this.get_full_name(), this.functional_cov.get_inst_coverage()), UVM_HIGH)
	endfunction: report_phase

endclass: my_coverage

