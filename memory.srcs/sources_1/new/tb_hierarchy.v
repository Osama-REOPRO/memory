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
// capacity (total words)
localparam L1_C  = 8;
localparam L2_C  = 16;
// block size (words per block)
localparam L1_b  = 2;
localparam L2_b  = 4;
// degree of associativity (blocks per set)
localparam L1_N  = 1;
localparam L2_N  = 2;


reg clk = 0, rst = 0, mem_op = 0;
reg [2:0] op;
reg [31:0] adrs;
reg [(4*L1_b)-1:0] valid_bytes;
reg [(32*L1_b)-1:0] w_data;
wire [(32*L1_b)-1:0] r_data;
wire done;
reg mem_op = 0;

integer state;
localparam idle_st 				= 0,
			  write_test_vals_st = 1,
			  read_test_vals_st 	= 2;

integer test_val = 0;
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

always #1 clk = ~clk;
	  
initial begin
	rst = 0;
	#10
	rst = 1;
	#10
	rst = 0;
end

always @(posedge clk) begin
	if (rst) begin
		{clk, mem_op, op, adrs, valid_bytes, w_data, test_val, sub_state, state} <= 0;
	end else begin
		case (state)

			idle_st: begin
				state <= write_test_vals_st;
			end

			write_test_vals_st: begin
				case (sub_state)
					init: begin
						w_data [(((adrs % (4*L1_b))+1)*8)-1 -: 8] <= test_val;
						// mul by 4 to get bytes per word, then by 8 to get bits per byte
						op 			     				  <= `write_op;
						mem_op    		  				  <= 1'b1;
						valid_bytes 	  				  <= {(4*L1_b){1'b0}};
						valid_bytes[adrs % (4*L1_b)] <= 1'b1;

						sub_state	     				  <= busy;
					end
					busy: begin
						if (done) begin
							mem_op <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!done) begin
							sub_state <= init;
							if (test_val <= 100) begin
								test_val <= test_val+1;
								adrs <= adrs+1;
							end else begin
								test_val <= 0;
								adrs <= 0;
								state <= read_test_vals_st;
							end
						end
					end
				endcase
			end
			read_test_vals_st: begin
				case (sub_state)
					init: begin
						op 			     				  <= `read_op;
						mem_op    		  				  <= 1'b1;
						valid_bytes 	  				  <= {(4*L1_b){1'b0}};
						valid_bytes[adrs % (4*L1_b)] <= 1'b1;

						sub_state	     				  <= busy;
					end
					busy: begin
						if (done) begin
							mem_op <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!done) begin
							sub_state <= init;
							if (adrs <= 100) begin
								adrs <= adrs+1;
							end else begin
								adrs <= 0;
								state <= idle_st;
							end
						end
					end
				endcase
			end
		endcase
	end
end

cache_hierarchy
#(
	// capacity (total words)
	.L1_C(L1_C),
	.L2_C(L2_C),
	// block size (words per block)
	.L1_b(L1_b),
	.L2_b(L2_b),
	// degree of associativity (blocks per set)
	.L1_N(L1_N),
	.L2_N(L2_N)
)
cache_hierarchy
(
	// essentially same as level 1 cache
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op), 				// read, write
	.i_address(adrs),

	.i_valid_bytes(valid_bytes), 	// valid bytes in read/write data, 1 for each valid byte

	.i_write_data(w_data),
	.o_read_data(r_data),

	.i_mem_operation(mem_op),
	.o_mem_operation_done(done)
);

endmodule

// logs
// initial $display("\n\n(%0t) logs start //////////////////////////////////////////\n\n", $time);
// always @(state) begin
// 	$write("(%0t) ", $time);
// 	$write("testbench state: (%0d) ", state);
// 	case (state)
// 		w_lookup_st : $write("write_lookup_st\n");
// 		w_st : $write("w_st\n");
// 		w_fill_empty_w_st : $write("w_fill_empty_w_st\n");
// 		w_evac_r_st : $write("w_evac_r_st\n");
// 		
// 		w_evac_h_lookup_st : $write("w_evac_h_lookup_st\n");
// 		w_evac_h_w_st : $write("w_evac_h_w_st\n");
// 		w_evac_h_fill_empty_w_st : $write("w_evac_h_fill_empty_w_st\n");
// 		w_evac_h_evac_r_st : $write("w_evac_h_evac_r_st\n");
// 		
// 		w_evac_h_evac_phy_lookup_st : $write("w_evac_h_evac_phy_lookup_st\n");
// 		w_evac_h_evac_phy_w_st : $write("w_evac_h_evac_phy_w_st\n");
// 		w_evac_h_evac_phy_fill_empty_w_st : $write("w_evac_h_evac_phy_fill_empty_w_st\n");
// 		w_evac_h_evac_phy_evac_r_st : $write("w_evac_h_evac_phy_evac_r_st\n");
// 		
// 		w_evac_h_evac_phy_evac_vir_lookup_st : $write("w_evac_h_evac_phy_evac_vir_lookup_st\n");
// 		w_evac_h_evac_phy_evac_vir_w_st : $write("w_evac_h_evac_phy_evac_vir_w_st\n");
// 		w_evac_h_evac_phy_evac_vir_fill_empty_w_st : $write("w_evac_h_evac_phy_evac_vir_fill_empty_w_st\n");
// 		
// 		r_lookup_st : $write("r_lookup_st\n");
// 		r_st : $write("r_st\n");
// 		r_fill_empty_w_st : $write("r_fill_empty_w_st\n");
// 		r_evac_r_st : $write("r_evac_r_st\n");
// 
// 	endcase
// end
// 
// `ifdef log_substates
// always @(sub_state) begin
// 	$write("(%0t) ", $time);
// 	$write("---> sub-state: ");
// 	case (sub_state)
// 		init: 	$write("init\n");
// 		busy: 	$write("busy\n");
// 		finish: 	$strobe("finish\n-----------------------------------------------------------------------------****\n\n");
// 	endcase
// end
// `endif
// 
// always @(hit_occurred[1]) $write("(%0t) ######### hit_occurred = %b\n", $time, hit_occurred[1]);
// always @(empty_found[1])  $write("(%0t) ######### empty_found = %b\n", $time, empty_found[1]);
// always @(clean_found[1])  $write("(%0t) ######### clean_found = %b\n", $time, clean_found[1]);
// 
// `ifdef log_L1_data
// always @(l1_cache.data_mem) begin
// 	$display();
// 	$display("l1_cache.data_mem:");
// 	$display(l1_cache.data_mem);
// 	$display();
// end
// `endif
// 
// `ifdef log_L2_data
// always @(l2_cache.data_mem) begin
// 	$display();
// 	$display("l2_cache.data_mem:");
// 	for (integer i = 0; i<L2_N; i=i+1) begin
// 		$write("(N=%0d) ", i);
// 		$write(l2_cache.data_mem[i]);
// 		$display();
// 	end
// 	$display();
// end
// `endif
// 
// `ifdef log_phy_data
// always @(physical_mem.data_mem) begin
// 	$display();
// 	$display("physical_mem.data_mem:");
// 	for (integer i = 0; i<Phy_N; i=i+1) begin
// 		$write("(N=%0d) ", i);
// 		$write(physical_mem.data_mem[i]);
// 		$display();
// 	end
// 	$display();
// end
// `endif
// 
// `ifdef log_vir_data
// always @(virtual_mem.data_mem) begin
// 	$display();
// 	$display("virtual_mem.data_mem:");
// 	for (integer i = 0; i<Vir_N; i=i+1) begin
// 		$write("(N=%0d) ", i);
// 		$write(virtual_mem.data_mem[i]);
// 		$display();
// 	end
// 	$display();
// end
// `endif


// initial begin
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

//	`ifdef log_valToWrite
//		$monitor("\n(%0t) ++++++++++++++++++++++++++++++++++ valToWrite: %b (%0d) +++++++++++++++++++++++++++++++++++\n", $time, valToWrite, valToWrite);
//	`endif
// end
//wire [7:0] previous_read_data = read_data_L1[address[1]-1 +: 8];
