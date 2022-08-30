import uvm_pkg::*;
import my_test_pkg::*;

module top_hdl_transition;

 tb_if my_dut_if();
 alu u (my_dut_if.A,my_dut_if.B,my_dut_if.ALU_sel,my_dut_if.ALU_out,my_dut_if.Carry_out);
 initial begin
	fork begin
 		uvm_config_db #(virtual tb_if)::set(null, "*", "DUT_IF", my_dut_if);
 		run_test("my_test");
	end
	begin
		my_dut_if.ALU_sel = 4'h0;
    #20;
    my_dut_if.ALU_sel = 4'h1;
    #20;
    my_dut_if.ALU_sel = 4'h2;
    #20;
	end
	join_any
	#5 $finish;
 end

endmodule 