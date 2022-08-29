
class my_monitor extends uvm_monitor;
	`uvm_component_utils(my_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual my_dut_interface tb_vif; // virtual interface

	uvm_analysis_port #(my_tx) dut_inputs_port; // analysis port for DUT inputs
	//uvm_analysis_port #(my_tx) dut_outputs_port; // analysis port for DUT outputs

	function void build_phase(uvm_phase phase);
		dut_inputs_port = new("dut_inputs_port", this); // construct the analysis port
		//dut_outputs_port = new("dut_outputs_port", this); // construct the analysis port
		if (!uvm_config_db #(virtual my_dut_interface)::get(this, "", "DUT_IF", tb_vif))
`			uvm_fatal("NOVIF", Failed to get virtual interface from uvm_config_db.\n")
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		my_tx tx_in, tx_copy;
		fork
		// monitor DUT inputs synchronous to the interface clock
	forever @(posedge tb_vif.clk) begin
		// create a new tx_write object for this cycle
		tx_in = my_tx::type_id::create("tx_in");
		tx_in.A = tb_vif.A;
		tx_in.B = tb_vif.B;
		tx_in.ALU_sel = tb_vif.ALU_sel;
		tx_in.ALU_out = tb_vif.ALU_out;
    tx_in.Carry_out = tb_vif.Carry_out;
		dut_inputs_port.write(tx_in);
	end
join
endtask: run_phase
endclass: my_monitor
