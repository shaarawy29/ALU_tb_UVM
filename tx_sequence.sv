import uvm_pkg::*;
import my_test_pkg::*;
`include "uvm_macros.svh"
//`include "my_tx.sv"

typedef class my_tx;

class tx_sequence extends uvm_sequence#(my_tx);
	`uvm_object_utils(tx_sequence)

	task body();
		for(int i =0; i < 4;i++) begin
		 my_tx tx = my_tx::type_id::create("tx");
			start_item(tx);

			if(i == 0) begin
				assert(tx.randomize() with{A >= 0;
																	A <= 63;
																  B >= 0;
																	B <= 63;});
			end

			if(i == 1) begin
				assert(tx.randomize() with{A >= 64;
																	A <= 127;
																  B >= 64;
																	B <= 127;});
			end
			if(i == 2) begin
				assert(tx.randomize() with{A >= 128;
																	A <= 191;
																  B >= 128;
																	B <= 191;});
			end
			if(i == 3) begin
				assert(tx.randomize() with{A >= 192;
																	A <= 255;
																  B >= 192;
																	B <= 255;});
			end	


			finish_item(tx);
	 end
#10;
endtask
endclass:tx_sequence

typedef uvm_sequencer #(my_tx) my_sequencer;