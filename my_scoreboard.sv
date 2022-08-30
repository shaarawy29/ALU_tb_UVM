import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
typedef class my_tx;
//`uvm_analysis_imp_decl(_verify_outputs)

class my_scoreboard extends uvm_subscriber #(my_tx);

	`uvm_component_utils(my_scoreboard)

	function new(string name, uvm_component parent );
		super.new(name, parent);
	endfunction: new

	//uvm_analysis_imp_verify_outputs #(my_tx, my_scoreboard) dut_out_imp_export;
	//mailbox #(my_tx) expected_fifo = new; // SystemVerilog mailbox for my_tx handles

	event ok;
	int num_passed, num_failed; // score cards

	function void build_phase(uvm_phase phase);
	 //dut_in_imp_export = new("dut_in_imp_export", this);
    if (!uvm_config_db #(event)::get(this, "", "ok", ok)) // revisit it in case not triggred
				`uvm_fatal("NO_OK", "Failed to get event from uvm_config_db.\n")
	endfunction

	// implement the write() method called by the monitor for observed DUT inputs;
	// predict what the DUT results should be for a set of input values

		function void write (my_tx t);
			my_tx expected_tx;
			$cast(expected_tx, t.clone()); // create new my_tx object and preserve input vals
			case (t.ALU_sel)
				4'b0000: // Addition
	     	{expected_tx.Carry_out,expected_tx.ALU_out} = t.A + t.B ; 
        4'b0001: // subtraction
				{expected_tx.Carry_out,expected_tx.ALU_out} = t.A - t.B ; 
				4'b0010: // multiplication
				{expected_tx.Carry_out,expected_tx.ALU_out} = t.A * t.B ;
	 			4'b0011: // division
				{expected_tx.Carry_out,expected_tx.ALU_out} = t.A / t.B ;
	 			4'b0100: // logical shift left
				{expected_tx.Carry_out,expected_tx.ALU_out} = t.A << 1 ; 
	 			4'b0101: // logical shift right
				{expected_tx.Carry_out,expected_tx.ALU_out} = t.A >> 1 ; 
	 			4'b0110: // rotate left
				{expected_tx.Carry_out,expected_tx.ALU_out} = {t.A[6:0],t.A[7]} ; 
	 			4'b0111: // rotate right
				{expected_tx.Carry_out,expected_tx.ALU_out} = {t.A[0],t.A[7:1]};
        4'b1000: //logical and
       	{expected_tx.Carry_out,expected_tx.ALU_out} = t.A & t.B;
        4'b1001://Logical or
      	{expected_tx.Carry_out,expected_tx.ALU_out} = t.A | t.B;
        4'b1010://Logical Xor
       	{expected_tx.Carry_out,expected_tx.ALU_out} = t.A ^ t.B;
        4'b1011://Logical nor
        {expected_tx.Carry_out,expected_tx.ALU_out} = ~(t.A | t.B);
        4'b1100:// Logical nand
       	{expected_tx.Carry_out,expected_tx.ALU_out} = ~(t.A & t.B);
        4'b1101: // Logical xnor
       	{expected_tx.Carry_out,expected_tx.ALU_out} = ~(t.A ^ t.B);
        4'b1110: // Greater comparison
       	{expected_tx.Carry_out,expected_tx.ALU_out} = (t.A > t.B)?8'd1:8'd0;
        4'b1111: // Equal comparison 
         {expected_tx.Carry_out,expected_tx.ALU_out} = (t.A == t.B)?8'd1:8'd0; 
        default:{expected_tx.Carry_out,expected_tx.ALU_out} = t.A & t.B; 
			endcase
		 // expected_tx.exception = ...
		//	expected_fifo.put(expected_tx); // save transaction handle

	 	if(expected_tx.ALU_out == t.ALU_out) begin
        	$display("[%t0] scoreboard pass! output match ref_item=0x%0h item=0x%0h",$time,expected_tx.ALU_out,t.ALU_out);
		   if((expected_tx.ALU_sel == 4'b0000)/*for addition*/ || (expected_tx.ALU_sel == 4'b0010)/*for multiplication*/) begin
			   if(expected_tx.Carry_out == t.Carry_out) begin
        			$display("[%t0] scoreboard pass! Carry match ref_item=0x%0h item=0x%0h",$time,expected_tx.Carry_out,t.Carry_out);
				$display("Right Instruction!");
					num_passed++;
       			end
        		else begin
         			$display("[%t0] scoreboard Error! Carry mismatch ref_item=0x%0h item=0x%0h",$time,expected_tx.Carry_out,t.Carry_out);
				$display("Wrong Instruction!");
					num_failed++;
        		end  
		end
		else begin
			$display("Right Instruction!");
			num_passed++;
		end
        end
        else begin
         	$display("[%t0] scoreboard Error! output mismatch ref_item=0x%0h item=0x%0h",$time,expected_tx.ALU_out,t.ALU_out);
					$display("Wrong Instruction!");
					num_failed++;
        end
       
		 		if((expected_tx.ALU_out == t.ALU_out) && (expected_tx.Carry_out == t.Carry_out) && (t.ALU_sel == 4'h0))begin
					->ok;
					end
				if((expected_tx.ALU_out == t.ALU_out) && (t.ALU_sel != 4'h0))begin
					->ok;
				end
endfunction: write

	function void report_phase(uvm_phase phase);
		`uvm_info("Scoreboard:", $sformatf("\n passed=%0d failed=%0d\n",
		num_passed, num_failed), UVM_NONE)
	endfunction: report_phase
endclass: my_scoreboard
