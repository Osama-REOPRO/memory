`timescale 1us / 1ns
`include "cache_ops.vh"

module tb_hierarchy;

localparam L1_C = 8;   		 // capacity (total words)
localparam L2_C = L1_C*2;
localparam L1_b = 2;   // block size (words per block)
localparam L2_b = L1_b*2;
localparam L1_N = 1;   // degree of associativity (blocks per set)
localparam L2_N = L1_N*2;


reg  			  			clk, rst;

reg [`op_N:0] 			op						 [1:2];

reg  [31:0]   			address 				 [1:2];

reg 			  			set_valid 			 [1:2];
reg			  			set_tag 				 [1:2];
reg 			  			set_dirty 			 [1:2];
reg 			  			set_use 				 [1:2];

reg  			  			mem_operation 		 [1:2];

wire 			  			hit_occurred  		 [1:2];
wire 			  			empty_found	 		 [1:2];
wire 			  			clean_found	 		 [1:2];

reg  [(4*L1_b)-1:0] 	valid_bytes_L1;
reg  [(4*L2_b)-1:0] 	valid_bytes_L2;

reg  [(32*L1_b)-1:0]	write_data_L1;
reg  [(32*L2_b)-1:0]	write_data_L2;

wire [(32*L1_b)-1:0]	read_data_L1;
wire [(32*L2_b)-1:0]	read_data_L2;

wire 						mem_operation_done [1:2];

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{	clk, rst,
	             
		op[1],
		op[2],
					 
		address[1],
		address[2],
		             
		set_dirty[1],
		set_dirty[2],
		set_use[1],
		set_use[2],
		             
		mem_operation[1],
		mem_operation[2],
		             		
		valid_bytes_L1,
		valid_bytes_L2,
		                  
		write_data_L1,
		write_data_L2 } = 0;


	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite [1:2];

integer state;
localparam write_lookup_st 	 	= 0,
			  write_st 		  		 	= 1,
			  write_fill_empty_w_st = 2,
			  write_evac_r_st  		= 3,
			  read_lookup_st		 	= 4,
			  read_st 		  		 	= 5,
			  read_fill_empty_w_st	= 6,
			  read_evac_r_st			= 7;
		  
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;
always @(posedge clk) begin : block_0
	integer il;
	if(rst) begin
		for (il=1; il<=2; il=il+1) begin
			mem_operation [il] <= 1'b0;
			address       [il] <= 1'b0;
			write_data_L1 [il] <= 1'b0;
			valToWrite 	  [il] <= 1'b0;
			state 		  [il] <= 0;
			sub_state	  [il] <= 0;
			
			set_valid	  [il] <= 1'b0;
			set_tag		  [il] <= 1'b0;
			set_dirty	  [il] <= 1'b0;
			set_use		  [il] <= 1'b0;
		end

	end else begin
		case (state)
			///////////// write
			write_lookup_st: begin

				case (sub_state)
					init: begin
						op[1]			  <= `lookup_op;
						mem_operation[1] <= 1'b1;

						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							if 	  (hit_occurred[1]) 					  state <= write_st;					 // write right away
							else if (empty_found[1] || clean_found[1])  state <= write_fill_empty_w_st; // fill with zeroes then write
							else 											  state <= write_evac_r_st;

							sub_state <= init;
						end
					end
				endcase
			end

			write_st: begin
				case (sub_state)
					init: begin
						write_data_L1 [(((address[1] % (4*L1_b))+1)*8)-1 -: 8] <= valToWrite[1];
						$display("write_data_L1 [%0d -: 8] <= %0d", ((address[1]+1)*8)-1, valToWrite[1]);
						op[1] 			     <= `write_op;
						mem_operation[1]    <= 1'b1;
						valid_bytes_L1 	  <= {(4*L1_b){1'b0}};
						valid_bytes_L1[address[1] % (4*L1_b)] <= 1'b1;

						set_dirty[1]		  <= 1'b1;
						set_use[1]			  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							state		 <= read_lookup_st;
							sub_state <= init;
						end
					end
				endcase
			end

			write_fill_empty_w_st: begin
				case (sub_state)
					init: begin
						write_data_L1 		  <= {(32*L1_b){1'b0}};
						op[1] 			     <= `write_op;
						mem_operation[1]    <= 1'b1;
						valid_bytes_L1		  <= {4*L1_b{1'b1}}; // all valid
						set_valid[1]		  <= 1'b1;
						set_tag[1]			  <= 1'b1;
						set_use[1]			  <= 1'b0;

						sub_state	     	  <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							state		 <= write_st;
							sub_state <= init;
						end
					end
				endcase
			end

				// we read the data but do nothing with it
				write_evac_r_st: begin
					case (sub_state)
						init: begin
							op[1] 			  <= `read_op;
							mem_operation[1] <= 1'b1;
							valid_bytes_L1	  <= {4*L1_b{1'b1}};

							sub_state		  <= busy;
						end
						busy: begin
							if (mem_operation_done[1]) begin
								mem_operation[1] <= 1'b0;

								sub_state 	  <= finish;
							end
						end
						finish: begin
							if (!mem_operation_done[1]) begin
								state		  <= write_fill_empty_w_st;
								sub_state  <= init;
							end
						end
					endcase
				end


			read_lookup_st: begin
				case (sub_state)
					init: begin
						op[1] 			  <= `lookup_op;
						mem_operation[1] <= 1'b1;

						sub_state	 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state	 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							if 	  (hit_occurred[1])	 					  state <= read_st;				  // read right away
							else if (empty_found[1] || clean_found[1])  state <= read_fill_empty_w_st; // fill with zeroes then write missing
							else 													  state <= read_evac_r_st;

							sub_state <= init;
						end
					end
				endcase
			end

			read_st: begin
				case (sub_state)
					init: begin
						op[1] 			     				  		<= `read_op;
						mem_operation[1]    				  		<= 1'b1;
						valid_bytes_L1 					  		<= {(4*L1_b){1'b0}};
						valid_bytes_L1[address[1] % (4*L1_b)] <= 1'b1;
						$strobe("\n\n\n");
						$strobe("valid_bytes_L1[address %% ((4*L1_b)-1)] <= 1'b1");
						$strobe("valid_bytes_L1[%0d %% ((4*%0d)-1)] <= 1'b1",address[1], L1_b);
						$strobe("valid_bytes_L1[%0d] <= 1'b1", address[1] % (4*L1_b));
						$strobe("valid_bytes_L1 = %b", valid_bytes_L1);
						$strobe("\n\n\n");

						sub_state	     				  		<= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							valToWrite[1] <= read_data_L1[(((address[1] % (4*L1_b))+1)*8)-1 -: 8] + 8'd1;
							address[1] 	  <= address[1] + 1;

							state		  <= write_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end


			// just fill with 0s
			read_fill_empty_w_st: begin
				case (sub_state)
					init: begin
						write_data_L1 <= {(32*L1_b){1'b0}};
						op[1] 			     <= `write_op;
						mem_operation[1]    <= 1'b1;
						valid_bytes_L1		  <= {4*L1_b{1'b1}};

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							state[1]	 <= read_st[1];

							sub_state <= init;
						end
					end
				endcase
			end

			read_evac_r_st: begin
				case (sub_state)
					init: begin
						op[1] 			     <= `read_op;
						mem_operation[1]    <= 1'b1;
						valid_bytes_L1		  <= {4*L1_b{1'b1}};

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							state		  <= read_st;
							sub_state  <= init;
						end
					end
				endcase
			end


		endcase
	end
end




cache 
#(
	.C(L1_C), // capacity (words)
	.b(L1_b), // block size (words in block)
	.N(L1_N)  // degree of associativity
) 
l1_cache
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op[1]),

	.i_address(address[1]),

	.i_set_valid(set_valid[1]),
	.i_set_tag(set_tag[1]),
	.i_set_dirty(set_dirty[1]),
	.i_set_use(set_use[1]),

	.i_mem_operation(mem_operation[1]),

	.o_hit_occurred(hit_occurred[1]),
	.o_empty_found(empty_found[1]),
	.o_clean_found(clean_found[1]),

	.i_valid_bytes(valid_bytes_L1),

	.i_write_data(write_data_L1),
	.o_read_data(read_data_L1),

	.o_mem_operation_done(mem_operation_done[1])
);

cache 
#(
	.C(L2_C), // capacity (words)
	.b(L2_b), // block size (words in block)
	.N(L2_N)  // degree of associativity
) 
l2_cache
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op[2]),

	.i_address(address[2]),

	.i_set_valid(set_valid[2]),
	.i_set_tag(set_tag[2]),
	.i_set_dirty(set_dirty[2]),
	.i_set_use(set_use[2]),

	.i_mem_operation(mem_operation[2]),

	.o_hit_occurred(hit_occurred[2]),
	.o_empty_found(empty_found[2]),
	.o_clean_found(clean_found[2]),

	.i_valid_bytes(valid_bytes_L2),

	.i_write_data(write_data_L2),
	.o_read_data(read_data_L2),

	.o_mem_operation_done(mem_operation_done[2])
);

// logs
initial $display("\n\n(%0t) logs start //////////////////////////////////////////\n\n", $time);
always @(state) begin
	$write("(%0t) ", $time);
	$write("---------------------------------------------------> testbench state: ");
	case (state)
		write_lookup_st: 			$write("write_lookup_st\n");
	   write_st: 					$write("write_st\n");
		write_fill_empty_w_st: 	$write("write_fill_empty_w_st\n");
		write_evac_r_st: 			$write("write_evac_r_st\n");
		read_lookup_st: 			$write("read_lookup_st\n");
		read_st: 					$write("read_st\n");
		read_fill_empty_w_st: 	$write("read_fill_empty_w_st\n");
		read_evac_r_st: 			$write("read_evac_r_st\n");
	endcase
end

always @(sub_state) begin
	$write("(%0t) ", $time);
	$write("--------------------------> sub-state: ");
	case (sub_state)
		init: 	$write("init\n");
		busy: 	$write("busy\n");
		finish: 	$strobe("finish\n-----------------------------------------------------------------------------****\n\n");
	endcase
end

always @(hit_occurred[1]) $write("(%0t) ######### hit_occurred = %b\n", $time, hit_occurred[1]);
always @(empty_found[1])  $write("(%0t) ######### empty_found = %b\n", $time, empty_found[1]);
always @(clean_found[1])  $write("(%0t) ######### clean_found = %b\n", $time, clean_found[1]);

initial begin
	$monitor(l1_cache.data_mem);
	$monitor("\n(t=%0t) ++++++++++++++++++++++++++++++++++ address = %0d ++++++++++++++++++++++++++++++++++\n", $time, address[1]);
	$monitor("\n(t=%0t) ++++++++++++++++++++++++++++++++++ valToWrite: %b +++++++++++++++++++++++++++++++++++\n", $time, valToWrite[1]);
end
wire [7:0] previous_read_data = read_data_L1[address[1]-1 +: 8];

endmodule
