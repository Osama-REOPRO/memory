`timescale 1us / 1ns
`include "cache_ops.vh"

module tb_hierarchy;

localparam L1_C  = 8;   	// capacity (total words)
localparam L2_C  = L1_C*2;
localparam Phy_C = L2_C*2;
localparam Vir_C = Phy_C*2;

localparam L1_b  = 2;   	// block size (words per block)
localparam L2_b  = L1_b*2;
localparam Phy_b = L2_b*2;
localparam Vir_b = Phy_b*2;

localparam L1_N  = 1;   	// degree of associativity (blocks per set)
localparam L2_N  = L1_N*2;
localparam Phy_N = L2_N*2;
localparam Vir_N = Vir_b; // fully associative


reg  			  clk, rst;

reg [`op_N:0] op						 [1:4];

reg  [31:0]   address 				 [1:4];

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

reg  [(32*L1_b)-1:0]	 write_data_L1;
reg  [(32*L2_b)-1:0]	 write_data_L2;
reg  [(32*Phy_b)-1:0] write_data_phy;
reg  [(32*Vir_b)-1:0] write_data_vir;

wire [(32*L1_b)-1:0]	 read_data_L1;
wire [(32*L2_b)-1:0]	 read_data_L2;
wire [(32*Phy_b)-1:0] read_data_phy;
wire [(32*Vir_b)-1:0] read_data_vir;


reg [(32*L1_b)-1:0]	 val_evac_L1;
reg [(32*L2_b)-1:0]	 val_evac_L2;
reg [(32*Phy_b)-1:0]	 val_evac_phy;
reg [(32*Vir_b)-1:0]	 val_evac_vir;

wire 						mem_operation_done [1:4];

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{	clk, rst,
	             
		op[1],
		op[2],
		op[3],
		op[4],
					 
		address[1],
		address[2],
		address[3],
		address[4],
		             
		set_dirty[1],
		set_dirty[2],
		set_dirty[3],
		set_dirty[4],

		set_use[1],
		set_use[2],
		set_use[3],
		set_use[4],
		             
		mem_operation[1],
		mem_operation[2],
		mem_operation[3],
		mem_operation[4],
		             		
		valid_bytes_L1,
		valid_bytes_L2,
		valid_bytes_phy,
		valid_bytes_vir,
		                  
		write_data_L1,
		write_data_L2,
		write_data_phy,
		write_data_vir } = 0;


	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite [1:4];

wire [($clog2(L2_b) > 0 ? $clog2(L2_b)-1 : 0) :0] block_offset_in_adrs_L2 = 
		(L2_b <= 1) ? 1'b0 : 
		address[2][2   +: ($clog2(L2_b) > 0) ? $clog2(L2_b) : 1];
wire [($clog2(Phy_b) > 0 ? $clog2(Phy_b)-1 : 0) :0] block_offset_in_adrs_phy = 
		(Phy_b <= 1) ? 1'b0 : 
		address[3][2   +: ($clog2(Phy_b) > 0) ? $clog2(Phy_b) : 1];
wire [($clog2(Vir_b) > 0 ? $clog2(Vir_b)-1 : 0) :0] block_offset_in_adrs_vir = 
		(Vir_b <= 1) ? 1'b0 : 
		address[4][2   +: ($clog2(Vir_b) > 0) ? $clog2(Vir_b) : 1];

integer state;
localparam w_lookup_st 	 		= 0,
			  w_st 		  		 	= 1,
			  w_fill_empty_w_st  = 2,
			  w_evac_r_st  		= 3,
			  
			  w_evac_h_lookup_st = 4,
			  w_evac_h_w_st		= 5,
			  w_evac_h_fill_empty_w_st = 6,
			  w_evac_h_evac_r_st			= 7,

			  w_evac_h_evac_phy_lookup_st = 8,
			  w_evac_h_evac_phy_w_st 		= 9,
			  w_evac_h_evac_phy_fill_empty_w_st = 10,
			  w_evac_h_evac_phy_evac_r_st			= 11,

			  w_evac_h_evac_phy_evac_vir_lookup_st = 12,
			  w_evac_h_evac_phy_evac_vir_w_st		= 13,
			  w_evac_h_evac_phy_evac_vir_fill_empty_w_st = 14,

			  r_lookup_st		 	= 15,
			  r_st 		  		 	= 16,
			  r_fill_empty_w_st	= 17,
			  r_evac_r_st			= 18;
		  
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;
always @(posedge clk) begin : block_0
	integer il;
	if(rst) begin
		state 	 <= 0;
		sub_state <= 0;

		for (il=1; il<=4; il=il+1) begin
			mem_operation [il] <= 1'b0;
			address       [il] <= 1'b0;
			write_data_L1 [il] <= 1'b0;
			valToWrite 	  [il] <= 1'b0;
			
			set_valid	  [il] <= 1'b0;
			set_tag		  [il] <= 1'b0;
			set_dirty	  [il] <= 1'b0;
			set_use		  [il] <= 1'b0;
		end

	end else begin
		case (state)
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
							else if (empty_found[1] || clean_found[1])  	state <= w_fill_empty_w_st; // fill with zeroes then write
							else 											  			state <= w_evac_r_st;

							sub_state <= init;
						end
					end
				endcase
			end

			w_st: begin
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
							state		 <= r_lookup_st;
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
						valid_bytes_phy		  <= {4*Phy_b{1'b1}}; // all valid
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
				// todo
				case (sub_state)
					init: begin
						write_data_phy		  <= {(32*Vir_b){1'b0}};
						op[4] 			     <= `write_op;
						mem_operation[4]    <= 1'b1;
						valid_bytes_vir		  <= {4*Vir_b{1'b1}}; // all valid
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
							if 	  (hit_occurred[1])	 					  state <= r_st;				  // read right away
							else if (empty_found[1] || clean_found[1])  state <= r_fill_empty_w_st; // fill with zeroes then write missing
							else 													  state <= r_evac_r_st;

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
							address[2] 	  <= address[1] + 1;

							state		  <= w_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end


			// just fill with 0s
			r_fill_empty_w_st: begin
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
							state[1]	 <= r_st[1];

							sub_state <= init;
						end
					end
				endcase
			end

			r_evac_r_st: begin
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
							state		  <= r_st;
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

cache 
#(
	.C(Phy_C), // capacity (words)
	.b(Phy_b), // block size (words in block)
	.N(Phy_N)  // degree of associativity
) 
physical_mem
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op[3]),

	.i_address(address[3]),

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
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op[4]),

	.i_address(address[4]),

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

// logs
initial $display("\n\n(%0t) logs start //////////////////////////////////////////\n\n", $time);
always @(state) begin
	$write("(%0t) ", $time);
	$write("---------------------------------------------------> testbench state: ");
	case (state)
		w_lookup_st: 			$write("write_lookup_st\n");
	   w_st: 					$write("write_st\n");
		w_fill_empty_w_st: 	$write("write_fill_empty_w_st\n");
		w_evac_r_st: 			$write("write_evac_r_st\n");
		r_lookup_st: 			$write("read_lookup_st\n");
		r_st: 					$write("read_st\n");
		r_fill_empty_w_st: 	$write("read_fill_empty_w_st\n");
		r_evac_r_st: 			$write("read_evac_r_st\n");
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
