`timescale 1us / 1ns
`include "cache_ops.vh"

// logs defs
`undef log_substates
`define log_valToWrite

`define log_L1_data
`define log_L2_data
`define log_phy_data
`define log_vir_data

module tb_hierarchy;


// logs
initial $display("\n\n(%0t) logs start //////////////////////////////////////////\n\n", $time);
always @(state) begin
	$write("(%0t) ", $time);
	$write("testbench state: (%0d) ", state);
	case (state)
		w_lookup_st : $write("write_lookup_st\n");
		w_st : $write("w_st\n");
		w_fill_empty_w_st : $write("w_fill_empty_w_st\n");
		w_evac_r_st : $write("w_evac_r_st\n");
		
		w_evac_h_lookup_st : $write("w_evac_h_lookup_st\n");
		w_evac_h_w_st : $write("w_evac_h_w_st\n");
		w_evac_h_fill_empty_w_st : $write("w_evac_h_fill_empty_w_st\n");
		w_evac_h_evac_r_st : $write("w_evac_h_evac_r_st\n");
		
		w_evac_h_evac_phy_lookup_st : $write("w_evac_h_evac_phy_lookup_st\n");
		w_evac_h_evac_phy_w_st : $write("w_evac_h_evac_phy_w_st\n");
		w_evac_h_evac_phy_fill_empty_w_st : $write("w_evac_h_evac_phy_fill_empty_w_st\n");
		w_evac_h_evac_phy_evac_r_st : $write("w_evac_h_evac_phy_evac_r_st\n");
		
		w_evac_h_evac_phy_evac_vir_lookup_st : $write("w_evac_h_evac_phy_evac_vir_lookup_st\n");
		w_evac_h_evac_phy_evac_vir_w_st : $write("w_evac_h_evac_phy_evac_vir_w_st\n");
		w_evac_h_evac_phy_evac_vir_fill_empty_w_st : $write("w_evac_h_evac_phy_evac_vir_fill_empty_w_st\n");
		
		r_lookup_st : $write("r_lookup_st\n");
		r_st : $write("r_st\n");
		r_fill_empty_w_st : $write("r_fill_empty_w_st\n");
		r_evac_r_st : $write("r_evac_r_st\n");

	endcase
end

`ifdef log_substates
always @(sub_state) begin
	$write("(%0t) ", $time);
	$write("---> sub-state: ");
	case (sub_state)
		init: 	$write("init\n");
		busy: 	$write("busy\n");
		finish: 	$strobe("finish\n-----------------------------------------------------------------------------****\n\n");
	endcase
end
`endif

always @(hit_occurred[1]) $write("(%0t) ######### hit_occurred = %b\n", $time, hit_occurred[1]);
always @(empty_found[1])  $write("(%0t) ######### empty_found = %b\n", $time, empty_found[1]);
always @(clean_found[1])  $write("(%0t) ######### clean_found = %b\n", $time, clean_found[1]);

`ifdef log_L1_data
always @(l1_cache.data_mem) begin
	$display();
	$display("l1_cache.data_mem:");
	$display(l1_cache.data_mem);
	$display();
end
`endif

`ifdef log_L2_data
always @(l2_cache.data_mem) begin
	$display();
	$display("l2_cache.data_mem:");
	for (integer i = 0; i<L2_N; i=i+1) begin
		$write("(N=%0d) ", i);
		$write(l2_cache.data_mem[i]);
		$display();
	end
	$display();
end
`endif

`ifdef log_phy_data
always @(physical_mem.data_mem) begin
	$display();
	$display("physical_mem.data_mem:");
	for (integer i = 0; i<Phy_N; i=i+1) begin
		$write("(N=%0d) ", i);
		$write(physical_mem.data_mem[i]);
		$display();
	end
	$display();
end
`endif

`ifdef log_vir_data
always @(virtual_mem.data_mem) begin
	$display();
	$display("virtual_mem.data_mem:");
	for (integer i = 0; i<Vir_N; i=i+1) begin
		$write("(N=%0d) ", i);
		$write(virtual_mem.data_mem[i]);
		$display();
	end
	$display();
end
`endif


initial begin
//	`ifdef log_L1_data
//		$monitor("l1_cache.data_mem: %h", l1_cache.data_mem);
//	`endif
//	`ifdef log_L2_data
//		$monitor("l2_cache.data_mem: ", l2_cache.data_mem);
//	`endif
//	`ifdef log_phy_data
//		$monitor("physical_mem.data_mem: ", physical_mem.data_mem);
//	`endif
//	`ifdef log_vir_data
//		$monitor("physical_mem.data_mem: ", physical_mem.data_mem);
//	`endif

//	`ifdef log_L1_data
//		$monitor("\n(t=%0t) ++++++++++++++++++++++++++++++++++ address = %0d ++++++++++++++++++++++++++++++++++\n", $time, address[1]);
//	`endif

	`ifdef log_valToWrite
		$monitor("\n(%0t) ++++++++++++++++++++++++++++++++++ valToWrite: %b (%0d) +++++++++++++++++++++++++++++++++++\n", $time, valToWrite, valToWrite);
	`endif
end
//wire [7:0] previous_read_data = read_data_L1[address[1]-1 +: 8];

endmodule
