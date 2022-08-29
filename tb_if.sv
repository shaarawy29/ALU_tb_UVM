interface ALU_if();
  logic [7:0] A;
  logic [7:0] B;
  logic [3:0] ALU_sel;
  logic [7:0] ALU_out;
  logic Carry_out;

  logic clk;
  initial clk <= 0;
  always #10 clk = ~clk;  

endinterface
