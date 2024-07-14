`timescale 1us / 1ns
`include "cache_ops.vh"

module cache_hierarchy
#(
	// capacity (total words)
	parameter L1_C  = 8,
	parameter L2_C  = 16,
	// block size (words per block)
	parameter L1_b  = 2,
	parameter L2_b  = 4,
	// degree of associativity (blocks per set)
	parameter L1_N  = 1,
	parameter L2_N  = 2
)
(
	// essentially same as level 1 cache
	input       			      i_clk,
	input         			      i_rst,

	input 	  [`op_N:0]	      i_op, 				// read, write
	input		  [31:0]		      i_address,

	input 	  [(4*L1_b)-1:0]  i_valid_bytes, 	// valid bytes in read/write data, 1 for each valid byte

	input 	  [(32*L1_b)-1:0] i_write_data,
	output reg [(32*L1_b)-1:0] o_read_data,

	input					   	   i_mem_operation,
	output reg				      o_mem_operation_done
);

localparam Phy_C = L2_C*2;
localparam Vir_C = Phy_C*2;

localparam Phy_b = L2_b*2;
localparam Vir_b = Phy_b*2;

localparam Phy_N = Phy_C/Phy_b; // fully associative (it was L2_N*2 before)
localparam Vir_N = Vir_C/Vir_b; // fully associative (it was Vir_b before)


reg [`op_N:0] op						 [1:4];

reg 			  set_valid 			 [1:4];
reg			  set_tag 				 [1:4];
reg 			  set_dirty 			 [1:4];
reg 			  set_use 				 [1:4];

reg  			  mem_operation 		 [1:4];

wire 			  hit_occurred  		 [1:4];
wire 			  empty_found	 		 [1:4];
wire 			  clean_found	 		 [1:4];

reg  [(4*L1_b)-1:0] 	 valid_bytes_L1;
reg  [(4*L2_b)-1:0] 	 valid_bytes_L2;
reg  [(4*Phy_b)-1:0]	 valid_bytes_phy;
reg  [(4*Vir_b)-1:0]	 valid_bytes_vir;
// always @(*) valid_bytes_L1 = i_valid_bytes; // first cache level is driven from outside directly

reg  [(32*L1_b)-1:0]	 write_data_L1;
reg  [(32*L2_b)-1:0]	 write_data_L2;
reg  [(32*Phy_b)-1:0] write_data_phy;
reg  [(32*Vir_b)-1:0] write_data_vir;
// always @(*) write_data_L1 = i_op == `write_op ? i_write_data : o_read_data; // first cache level is driven from outside directly
// it is assigned read data in case we need to

wire [(32*L1_b)-1:0]	 read_data_L1;
wire [(32*L2_b)-1:0]	 read_data_L2;
wire [(32*Phy_b)-1:0] read_data_phy;
wire [(32*Vir_b)-1:0] read_data_vir;


reg [(32*L1_b)-1:0]	 val_evac_L1;
reg [(32*L2_b)-1:0]	 val_evac_L2;
reg [(32*Phy_b)-1:0]	 val_evac_phy;
reg [(32*Vir_b)-1:0]	 val_evac_vir;

wire 						mem_operation_done [1:4];


wire [($clog2(L2_b) > 0 ? $clog2(L2_b)-1 : 0) :0] block_offset_in_adrs_L2 = 
		(L2_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(L2_b) > 0) ? $clog2(L2_b) : 1];
wire [($clog2(Phy_b) > 0 ? $clog2(Phy_b)-1 : 0) :0] block_offset_in_adrs_phy = 
		(Phy_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(Phy_b) > 0) ? $clog2(Phy_b) : 1];
wire [($clog2(Vir_b) > 0 ? $clog2(Vir_b)-1 : 0) :0] block_offset_in_adrs_vir = 
		(Vir_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(Vir_b) > 0) ? $clog2(Vir_b) : 1];

integer state;
localparam idle_st				= 0,
			  done_st				= 1,
			  w_lookup_st 	 		= 2,
			  w_st 		  		 	= 3,
			  w_fill_empty_w_st  = 4,
			  w_evac_r_st  		= 5,
			  
			  w_evac_h_lookup_st = 6,
			  w_evac_h_w_st		= 7,
			  w_evac_h_fill_empty_w_st = 8,
			  w_evac_h_evac_r_st			= 9,

			  w_evac_h_evac_phy_lookup_st = 10,
			  w_evac_h_evac_phy_w_st 		= 11,
			  w_evac_h_evac_phy_fill_empty_w_st = 12,
			  w_evac_h_evac_phy_evac_r_st			= 13,

			  w_evac_h_evac_phy_evac_vir_lookup_st = 14,
			  w_evac_h_evac_phy_evac_vir_w_st		= 15,
			  w_evac_h_evac_phy_evac_vir_fill_empty_w_st = 16,

			  r_lookup_st		 	= 17,
			  r_h_lookup_st		= 18,
			  r_phy_lookup_st		= 19,
			  r_vir_lookup_st		= 20,

			  r_st 		  		 	= 21,
			  r_h_st 		  		= 22,
			  r_phy_st 		  		= 23,
			  r_vir_st 		  		= 24,

			  r_data_doesnt_exist_st = 25;
		  
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

integer i;
always @(posedge i_clk) begin : block_0
	if(i_rst) begin
		state 	 <= 0;
		sub_state <= 0;

		{ 	valid_bytes_L1,
			valid_bytes_L2,
			valid_bytes_phy,
			valid_bytes_vir,
									
			write_data_L1,
			write_data_L2,
			write_data_phy,
			write_data_vir } = 0;

		for (i=1; i<=4; i=i+1) begin
			op[i]					<= 1'b0;
			mem_operation [i] <= 1'b0;
			
			set_valid	  [i] <= 1'b0;
			set_tag		  [i] <= 1'b0;
			set_dirty	  [i] <= 1'b0;
			set_use		  [i] <= 1'b0;
		end

	end else begin
		case (state)
			idle_st: begin
				// we only enter the idle state when read or write done, no other way
				o_mem_operation_done = 1'b0;
				if (i_mem_operation) begin
					case (i_op)
						`write_op: state = w_lookup_st;
						`read_op: state = r_lookup_st;
						default: state = idle_st;
					endcase
				end
			end

			done_st: begin
				o_mem_operation_done = 1'b1;
				if (!i_mem_operation) state = idle_st;
			end
			
			///////////// write
			w_lookup_st: begin

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
							if 	  (hit_occurred[1]) 					  		state <= w_st;					 // write right away
							else if (empty_found[1] || clean_found[1])  	state <= w_fill_empty_w_st; // fill with missing data from above
							else 											  			state <= w_evac_r_st;

							sub_state <= init;
						end
					end
				endcase
			end

			w_st: begin
				case (sub_state)
					init: begin
						case (i_op)
							`write_op: write_data_L1 <= i_write_data;
							`read_op: write_data_L1 <= o_read_data;
						endcase
						op[1] 			     <= `write_op;
						mem_operation[1]    <= 1'b1;
						valid_bytes_L1 	  <= {(4*L1_b){1'b0}};
						valid_bytes_L1[i_address % (4*L1_b)] <= 1'b1;

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
							state		 <= done_st;
							sub_state <= init;
						end
					end
				endcase
			end

			w_fill_empty_w_st: begin
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
							state		 <= w_st;
							sub_state <= init;
						end
					end
				endcase
			end

			// we read the data then write it to a higher level cache
			w_evac_r_st: begin
				case (sub_state)
					init: begin
						op[1] 			  								<= `read_op;
						mem_operation[1] 								<= 1'b1;
						valid_bytes_L1									<= {(4*L1_b){1'b1}}; // read entire block

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
							val_evac_L1 <= read_data_L1;
							state		  <= w_evac_h_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end

			// lookup higher cache for space to write evacuated data to
			w_evac_h_lookup_st: begin
				case (sub_state)
					init: begin
						op[2]			  <= `lookup_op;
						mem_operation[2] <= 1'b1;

						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							if 	  (hit_occurred[2]) 					  		state <= w_evac_h_w_st;		// write right away
							else if (empty_found[2] || clean_found[2])  	state <= w_evac_h_fill_empty_w_st; 	// fill with zeroes then write
							else 											  			state <= w_evac_h_evac_r_st; // higher also needs an evac, so read value

							sub_state <= init;
						end
					end
				endcase
			end

			// write the evacuated data to higher level
			w_evac_h_w_st: begin
				case (sub_state)
					init: begin
						write_data_L2 [(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b] <= val_evac_L1;
						op[2] 			  <= `write_op;
						mem_operation[2] <= 1'b1;
						valid_bytes_L2   <= {(4*L2_b){1'b0}}; // done: this also makes no sense, not all are valid, the data isn't enough
						valid_bytes_L2[block_offset_in_adrs_L2 * 4 +: 4*L1_b] <= {(4*L1_b){1'b1}};

						set_dirty[2]	  <= 1'b1;
						set_use[2]		  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							state		 <= w_fill_empty_w_st;
							sub_state <= init;
						end
					end
				endcase
			end

			w_evac_h_fill_empty_w_st: begin
				case (sub_state)
					init: begin
						write_data_L2 		  <= {(32*L2_b){1'b0}};
						op[2] 			     <= `write_op;
						mem_operation[2]    <= 1'b1;
						valid_bytes_L2		  <= {4*L2_b{1'b1}}; // all valid
						set_valid[2]		  <= 1'b1;
						set_tag[2]			  <= 1'b1;
						set_use[2]			  <= 1'b0;

						sub_state	     	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							state		 <= w_evac_h_w_st;
							sub_state <= init;
						end
					end
				endcase
			end

			w_evac_h_evac_r_st: begin
				case (sub_state)
					init: begin
						op[2] 			  <= `read_op;
						mem_operation[2] <= 1'b1;
						valid_bytes_L2	  <= {(4*L2_b){1'b1}}; // read entire block

						sub_state		  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							val_evac_L2 <= read_data_L2;
							// write data to higher levels
							state		  	<= w_evac_h_evac_phy_lookup_st;
							sub_state  	<= init;
						end
					end
				endcase
			end

			w_evac_h_evac_phy_lookup_st: begin
				// check if there is space to write the data evacuated from below
				case (sub_state)
					init: begin
						op[3]			  <= `lookup_op;
						mem_operation[3] <= 1'b1;

						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							if 	  (hit_occurred[3]) 					  		state <= w_evac_h_evac_phy_w_st;		// write right away
							else if (empty_found[3] || clean_found[3])  	state <= w_evac_h_evac_phy_fill_empty_w_st; 	// fill with zeroes then write
							else 											  			state <= w_evac_h_evac_phy_evac_r_st; // physical also needs an evac, so read value

							sub_state <= init;
						end
					end
				endcase

			end

			w_evac_h_evac_phy_w_st: begin
				// write evacuated data
				case (sub_state)
					init: begin
						write_data_phy [(block_offset_in_adrs_phy*4*8) +: 8*4*Phy_b] <= val_evac_L2;
						op[3] 			  <= `write_op;
						mem_operation[3] <= 1'b1;
						valid_bytes_phy   <= {(4*Phy_b){1'b0}}; // done: this also makes no sense, not all are valid, the data isn't enough
						valid_bytes_phy[block_offset_in_adrs_phy * 4 +: 4*L2_b] <= {(4*L2_b){1'b1}};

						set_dirty[3]	  <= 1'b1;
						set_use[3]		  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							state		 <= w_evac_h_fill_empty_w_st; // go back down and continue
							sub_state <= init;
						end
					end
				endcase
			end

			w_evac_h_evac_phy_fill_empty_w_st: begin
				// fill empty before write
				case (sub_state)
					init: begin
						write_data_phy		  <= {(32*Phy_b){1'b0}};
						op[3] 			     <= `write_op;
						mem_operation[3]    <= 1'b1;
						valid_bytes_phy	  <= {(4*Phy_b){1'b1}}; // all valid
						set_valid[3]		  <= 1'b1;
						set_tag[3]			  <= 1'b1;
						set_use[3]			  <= 1'b0;

						sub_state	     	  <= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							state		 <= w_evac_h_evac_phy_w_st;
							sub_state <= init;
						end
					end
				endcase
			end

			w_evac_h_evac_phy_evac_r_st: begin
				// evacuate to virtual
				case (sub_state)
					init: begin
						op[3] 			  <= `read_op;
						mem_operation[3] <= 1'b1;
						valid_bytes_phy	  <= {(4*Phy_b){1'b1}}; // read entire block

						sub_state		  <= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							val_evac_phy <= read_data_phy;
							// write data to higher levels
							state		  	<= w_evac_h_evac_phy_evac_vir_lookup_st;
							sub_state  	<= init;
						end
					end
				endcase
			end

			w_evac_h_evac_phy_evac_vir_lookup_st: begin
				// todo: last level of memory, this one can't miss
				case (sub_state)
					init: begin
						op[4]			  <= `lookup_op;
						mem_operation[4] <= 1'b1;

						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[4]) begin
							mem_operation[4] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[4]) begin
							if   (hit_occurred[4]) state <= w_evac_h_evac_phy_evac_vir_w_st;					// write right away
							else 						  state <= w_evac_h_evac_phy_evac_vir_fill_empty_w_st; 	// fill with zeroes then write

							sub_state <= init;
						end
					end
				endcase

			end

			w_evac_h_evac_phy_evac_vir_w_st: begin
				case (sub_state)
					init: begin
						write_data_vir [(block_offset_in_adrs_vir*4*8) +: 8*4*Vir_b] <= val_evac_phy;
						op[4] 			  <= `write_op;
						mem_operation[4] <= 1'b1;
						valid_bytes_vir   <= {(4*Vir_b){1'b0}}; // done: this also makes no sense, not all are valid, the data isn't enough
						valid_bytes_vir[block_offset_in_adrs_vir * 4 +: 4*Phy_b] <= {(4*Phy_b){1'b1}};

						set_dirty[4]	  <= 1'b1;
						set_use[4]		  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[4]) begin
							mem_operation[4] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[4]) begin
							state		 <= w_evac_h_evac_phy_fill_empty_w_st; // go back down and continue
							sub_state <= init;
						end
					end
				endcase
			end

			w_evac_h_evac_phy_evac_vir_fill_empty_w_st: begin
				// fill empty before write
				case (sub_state)
					init: begin
						write_data_vir		  <= {(32*Vir_b){1'b0}};
						op[4] 			     <= `write_op;
						mem_operation[4]    <= 1'b1;
						valid_bytes_vir		  <= {(4*Vir_b){1'b1}}; // all valid
						set_valid[4]		  <= 1'b1;
						set_tag[4]			  <= 1'b1;
						set_use[4]			  <= 1'b0;

						sub_state	     	  <= busy;
					end
					busy: begin
						if (mem_operation_done[4]) begin
							mem_operation[4] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[4]) begin
							state		 <= w_evac_h_evac_phy_evac_vir_w_st;
							sub_state <= init;
						end
					end
				endcase
			end

			/////////////////////// read phase
			r_lookup_st: begin
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
							if (hit_occurred[1]) state <= r_st;				// read right away
							else 						state <= r_h_lookup_st;

							sub_state <= init;
						end
					end
				endcase
			end

			r_h_lookup_st: begin
				case (sub_state)
					init: begin
						op[2] 			  <= `lookup_op;
						mem_operation[2] <= 1'b1;

						sub_state	 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state	 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							if (hit_occurred[2]) state <= r_h_st;				// read right away
							else 						state <= r_phy_lookup_st;

							sub_state <= init;
						end
					end
				endcase
			end

			r_phy_lookup_st: begin
				case (sub_state)
					init: begin
						op[3] 			  <= `lookup_op;
						mem_operation[3] <= 1'b1;

						sub_state	 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state	 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							if (hit_occurred[3]) state <= r_phy_st;				// read right away
							else 						state <= r_vir_lookup_st;

							sub_state <= init;
						end
					end
				endcase
			end

			r_vir_lookup_st: begin
				case (sub_state)
					init: begin
						op[4] 			  <= `lookup_op;
						mem_operation[4] <= 1'b1;

						sub_state	 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[4]) begin
							mem_operation[4] <= 1'b0;

							sub_state	 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[4]) begin
							if (hit_occurred[4]) state <= r_vir_st;				// read right away
							else 						state <= r_data_doesnt_exist_st;

							sub_state <= init;
						end
					end
				endcase
			end


			r_st: begin
				case (sub_state)
					init: begin
						op[1] 			     				  		<= `read_op;
						mem_operation[1]    				  		<= 1'b1;
						valid_bytes_L1 					  		<= {(4*L1_b){1'b0}};
						valid_bytes_L1[i_address % (4*L1_b)] <= 1'b1;

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
							o_read_data <= read_data_L1;

							state		  <= done_st;
							sub_state  <= init;
						end
					end
				endcase
			end

			r_h_st: begin
				case (sub_state)
					init: begin
						op[2] 			     				  		<= `read_op;
						mem_operation[2]    				  		<= 1'b1;
						valid_bytes_L2 					  		<= {(4*L2_b){1'b0}}; // todo: check if correct
						valid_bytes_L2[i_address % (4*L2_b)] <= 1'b1; // todo: check if correct

						sub_state	     				  		<= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							o_read_data <= read_data_L2;

							state		  <= w_lookup_st; // write missed data to lowest level
							sub_state  <= init;
						end
					end
				endcase
			end

			r_phy_st: begin
				case (sub_state)
					init: begin
						op[3] 			     				  		<= `read_op;
						mem_operation[3]    				  		<= 1'b1;
						valid_bytes_phy 					  		<= {(4*Phy_b){1'b0}};
						valid_bytes_phy[i_address % (4*Phy_b)] <= 1'b1;

						sub_state	     				  		<= busy;
					end
					busy: begin
						if (mem_operation_done[3]) begin
							mem_operation[3] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[3]) begin
							o_read_data <= read_data_phy;

							state		  <= w_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end

			r_vir_st: begin
				case (sub_state)
					init: begin
						op[4] 			     				  		<= `read_op;
						mem_operation[4]    				  		<= 1'b1;
						valid_bytes_vir 					  		<= {(4*Vir_b){1'b0}};
						valid_bytes_vir[i_address % (4*Vir_b)] <= 1'b1;

						sub_state	     				  		<= busy;
					end
					busy: begin
						if (mem_operation_done[4]) begin
							mem_operation[4] <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[4]) begin
							o_read_data <= read_data_vir;

							state		  <= w_lookup_st;
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
	.i_clk(i_clk),
	.i_rst(i_rst),

	.i_op(op[1]),

	.i_address(i_address),

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
	.i_clk(i_clk),
	.i_rst(i_rst),

	.i_op(op[2]),

	.i_address(i_address),

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

cache 
#(
	.C(Phy_C), // capacity (words)
	.b(Phy_b), // block size (words in block)
	.N(Phy_N)  // degree of associativity
) 
physical_mem
(
	.i_clk(i_clk),
	.i_rst(i_rst),

	.i_op(op[3]),

	.i_address(i_address),

	.i_set_valid(set_valid[3]),
	.i_set_tag(set_tag[3]),
	.i_set_dirty(set_dirty[3]),
	.i_set_use(set_use[3]),

	.i_mem_operation(mem_operation[3]),

	.o_hit_occurred(hit_occurred[3]),
	.o_empty_found(empty_found[3]),
	.o_clean_found(clean_found[3]),

	.i_valid_bytes(valid_bytes_phy),

	.i_write_data(write_data_phy),
	.o_read_data(read_data_phy),

	.o_mem_operation_done(mem_operation_done[3])
);

cache 
#(
	.C(Vir_C), // capacity (words)
	.b(Vir_b), // block size (words in block)
	.N(Vir_N)  // degree of associativity
) 
virtual_mem
(
	.i_clk(i_clk),
	.i_rst(i_rst),

	.i_op(op[4]),

	.i_address(i_address),

	.i_set_valid(set_valid[4]),
	.i_set_tag(set_tag[4]),
	.i_set_dirty(set_dirty[4]),
	.i_set_use(set_use[4]),

	.i_mem_operation(mem_operation[4]),

	.o_hit_occurred(hit_occurred[4]),
	.o_empty_found(empty_found[4]),
	.o_clean_found(clean_found[4]),

	.i_valid_bytes(valid_bytes_vir),

	.i_write_data(write_data_vir),
	.o_read_data(read_data_vir),

	.o_mem_operation_done(mem_operation_done[4])
);

endmodule
