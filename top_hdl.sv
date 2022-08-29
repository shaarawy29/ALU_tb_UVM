module top_hdl;

 import uvm_pkg::*;
 import my_test_pkg::*;

 tb_if my_dut_if();
 alu u (my_dut_if.A,my_dut_if.B,my_dut_if.ALU_sel,my_dut_if.ALU_out,my_dut_if.Carry_out);
 initial begin
 uvm_config_db #(virtual tb_if)::set(null, "uvm_test_top", "DUT_IF", my_dut_if);
 run_test();
 end
endmodule 
