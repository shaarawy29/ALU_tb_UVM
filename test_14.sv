import uvm_pkg::*;
import my_test_pkg::*;

module test_14;

 tb_if my_dut_if();
 alu u (my_dut_if.A,my_dut_if.B,my_dut_if.ALU_sel,my_dut_if.ALU_out,my_dut_if.Carry_out);
 initial begin
	my_dut_if.ALU_sel = 4'he;
 uvm_config_db #(virtual tb_if)::set(null, "*", "DUT_IF", my_dut_if);
 run_test("my_test");
 end

endmodule 
