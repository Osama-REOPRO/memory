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
	// same as level 1 cache
	input       			      i_clk,
	input         			      i_rst,

	input 	  [`op_N:0]	      i_op,
	input		  [31:0]		      i_address,

	input 	  [(4*L1_b)-1:0]  i_valid_bytes,

	input 	  [(32*L1_b)-1:0] i_write_data,
	output reg [(32*L1_b)-1:0] o_read_data,

	input					   	   i_mem_operation,
	output reg				      o_mem_operation_done,
	
	// interface with higher memory, same as level 2 cache
	output reg [`op_N:0]	      o_op,
	output reg [31:0]		   	o_address,

	output reg [(4*L2_b)-1:0]  o_valid_bytes,

	output reg [(32*L2_b)-1:0] o_write_data,
	input		  [(32*L2_b)-1:0] i_read_data,

	output reg			   	   o_mem_operation,
	input								i_mem_operation_done
);

reg [`op_N:0] op;

reg set_valid;
reg set_tag;
reg set_dirty;
reg set_use;

reg mem_operation [1:2];
wire mem_operation_done [1:2];

wire hit_occurred [1:2];
wire empty_found  [1:2];
wire clean_found  [1:2];


reg  [(4*L1_b)-1:0] valid_bytes_L1;
reg  [(4*L2_b)-1:0] valid_bytes_L2;

reg  [(32*L1_b)-1:0] write_data_L1;
reg  [(32*L2_b)-1:0] write_data_L2;

wire [(32*L1_b)-1:0] read_data_L1;
wire [(32*L2_b)-1:0] read_data_L2;

reg [(32*L1_b)-1:0] val_evac_L1;
reg [(32*L2_b)-1:0] val_evac_L2;

// conditional signals
wire both_missed = !hit_occurred[1] && !hit_occurred[2];
wire only_second_hit = !hit_occurred[1] && hit_occurred[2];

wire is_write_op = i_op == `write_op;
wire is_read_op = i_op == `read_op;

wire write_needed_L1 = is_write_op || (is_read_op && !hit_occurred[1]);
wire conflict_occurred_L1 = write_needed_L1 && !hit_occurred[1] && !empty_found[1];
wire evac_needed_L1 = conflict_occurred_L1 && !clean_found[1];
// because we are inclusive now, conflict means one of two things:
// - either the conflicting value is clean, in which case we simply overwrite
// it, because being inclusive it must exist in the upper level
// - or it is dirty, in which case we need to read and write it to upper level,
// and we are confident that it does exist in upper level because inclusive

wire write_needed_L2 = evac_needed_L1 || both_missed;
wire conflict_occurred_L2 = write_needed_L2 && !hit_occurred[2] && !empty_found[2];
wire evac_needed_L2 = conflict_occurred_L2 && !clean_found[2];

wire read_needed_L1 = is_read_op || evac_needed_L1;
wire read_needed_L2 = only_second_hit || evac_needed_L2;
// you only need to read it in 2 cases:
// - read when hit and lower miss to write to lower level
// - read to evac to higher level

wire read_needed_Main = both_missed;
wire write_needed_main = evac_needed_L2;

wire evac_needed_both = evac_needed_L1 && evac_needed_L2;


wire [($clog2(L2_b) > 0 ? $clog2(L2_b)-1 : 0) :0] block_offset_in_adrs_L2 = 
		(L2_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(L2_b) > 0) ? $clog2(L2_b) : 1];


// state machine
integer state;
localparam idle_st	= 0,
			  done_st	= 1,
			  lookup_st	= 2,
			  read_st	= 3,
			  write_st	= 4;

integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

integer lookup_sub_state;
localparam lookup_L1_st   = 0,
			  lookup_L2_st	  = 1,
			  lookup_done_st = 2;


integer read_sub_state;
localparam read_L1_st   = 0,
			  read_L2_st	= 1,
			  read_Main_st = 2,
			  read_done_st = 3;

integer write_sub_state;
localparam write_L1_st   = 0,
			  write_L2_st	 = 1,
			  write_Main_st = 2,
			  write_done_st = 3;


integer i;

always @(posedge i_clk) begin
	if(i_rst) begin
		i <= 0;
		state 	 <= 0;
		sub_state <= 0;
		lookup_sub_state <= 0;
		read_sub_state <= 0;
		write_sub_state <= 0;

		{ 	valid_bytes_L1,
			valid_bytes_L2,
									
			write_data_L1,
			write_data_L2,

			set_valid,
			set_tag,
			set_dirty,
			set_use,

			op[1],
			op[2],

			mem_operation[1],
			mem_operation[2],
			o_op,
			o_address,
			o_valid_bytes,
			o_write_data,
			o_mem_operation } = 0;

	end else begin
		case (state)

			idle_st: begin
				o_mem_operation_done <= 1'b0;
				if (i_mem_operation) begin
					state <= lookup_st;
				end
			end

			done_st: begin
				o_mem_operation_done = 1'b1;
				if (!i_mem_operation) state = idle_st;
			end

			lookup_st: begin
				case (lookup_sub_state)

					lookup_L1_st: begin
						case (sub_state)
							init: begin
								op			  <= `lookup_op;
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
									if (hit_occurred[1]) lookup_sub_state <= lookup_done_st;
									else 						lookup_sub_state <= lookup_L2_st;

									sub_state <= init;
								end
							end
						endcase
					end

					lookup_L2_st: begin
						case (sub_state)
							init: begin
								op			  <= `lookup_op;
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
									lookup_sub_state <= lookup_done_st; // whether we hit or not
									sub_state <= init;
								end
							end
						endcase
					end


					lookup_done_st: begin
						case (i_op)
							`write_op: begin
								if (hit_occurred[1]) state <= write_st;
								else state <= read_st;
							end
							`read_op: begin
								state <= read_st;
							end
						endcase

						lookup_sub_state <= 0;
					end

				endcase
			end






			read_st: begin
				case (read_sub_state)
					read_L1_st: begin
						case (sub_state)
							init: begin
								op 			   <= `read_op;
								mem_operation[1]  <= 1'b1;
								valid_bytes_L1 <= {(4*L1_b){1'b1}}; // how about all valid? while reading that it

								sub_state		<= busy;
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

									read_sub_state		  <= read_needed_L2 ? read_L2_st : read_done_st;
									sub_state  <= init;
								end
							end
						endcase
					end

					read_L2_st: begin
						case (sub_state)
							init: begin
								op 			   <= `read_op;
								mem_operation[2]  <= 1'b1;
								valid_bytes_L2 <= {(4*L2_b){1'b1}}; // how about all valid? while reading that it

								sub_state		<= busy;
							end
							busy: begin
								if (mem_operation_done[2]) begin
									mem_operation[2] <= 1'b0;

									sub_state 	  <= finish;
								end
							end
							finish: begin
								if (!mem_operation_done[2]) begin
									read_sub_state		  <= read_needed_Main ? read_Main_st : read_done_st;
									sub_state  <= init;
								end
							end
						endcase
					end

					read_Main_st: begin
						case (sub_state)
							init: begin
								o_op 			   <= `read_op;
								o_mem_operation  <= 1'b1;
								o_valid_bytes <= {(4*L2_b){1'b1}}; // how about all valid? while reading that it

								sub_state		<= busy;
							end
							busy: begin
								if (i_mem_operation_done) begin
									o_mem_operation <= 1'b0;

									sub_state 	  <= finish;
								end
							end
							finish: begin
								if (!i_mem_operation_done) begin
									read_sub_state		  <= read_done_st;
									sub_state  <= init;
								end
							end
						endcase
					end

					read_done_st: begin
						case (i_op)
							`write_op: begin
								state <= write_st;
							end
							`read_op: begin
								if (hit_occurred[1]) begin
									o_read_data <= read_data_L1;
									state <= done_st;
								end else if (hit_occurred[2]) begin
									o_read_data <= read_data_L2;
									state <= write_st;
								end else begin
									o_read_data <= i_read_data; // data read from main memory
									state <= write_st;
								end
							end
						endcase
						read_sub_state <= 0;
					end
				endcase
				
			end





			write_st: begin
			   case (write_sub_state)
					
					write_L1_st: begin
						case (sub_state)
							init: begin

								if (hit_occurred[1]) begin
									write_data_L1  <= i_write_data; // write directly
									valid_bytes_L1 <= i_valid_bytes; // write only some bytes not all
									// note: no need to differentiate betrween read_op
									// and write_op in the case where a hit occurred on
									// L1, because if a hit had occurred on L1 we
									// wouldn't have entered the write state to begin
									// with

								end else if (hit_occurred[2]) begin
									valid_bytes_L1 <= {(4*L1_b){1'b1}}; // overwrite all bytes
									case (i_op)
										`read_op: begin
											write_data_L1 <= read_data_L2[(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b];
											// todo: check if this works
											// this complication is because we can't just always use the lower part of the data from L2, 
											// because what if the data we want isn't in the lower part but the middle one or upper one? 
											// I need to change what part of it I get based on address
										end
										`write_op: begin
											// combine data read from 2nd level with new data coming from input
											for (i=0; i<(4*L1_b); i=i+1) begin
												write_data_L1[(i*8)-1 +: 8] <= i_valid_bytes[i] ?
													i_write_data[(i*8)-1 +: 8] : read_data_L2[(i*8)-1 +: 8];
											end
										end
									endcase
								end else begin
									// data must have been fetched from main memory
									case (i_op)
										`read_op: write_data_L1 <= i_read_data[(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b];
										`write_op: begin
											// combine data read from main with new data coming from input
											for (i=0; i<(4*L1_b); i=i+1) begin
												write_data_L1[(i*8)-1 +: 8] <= i_valid_bytes[i] ?
													i_write_data[(i*8)-1 +: 8] : i_read_data[(i*8)-1 +: 8];
											end
										end
									endcase
								end

								op 			     <= `write_op;
								mem_operation[1]    <= 1'b1;

								set_dirty		  <= 1'b1;
								set_use			  <= 1'b1;

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
									state <= write_needed_L2 ? write_L2_st : write_done_st;

									sub_state <= init;
								end
							end
						endcase
					end

					write_L2_st: begin
						case (sub_state)
							init: begin

								// in second cache we write in only two cases:
								// - evac dirty from below
								// 		happens on both reads and writes
								// - fill missing from above
								// 		could only happen on read miss both

								if (both_missed) begin
									// if both missed, aint no other place the data
									// could be coming from but above!
									write_data_L2 <= i_read_data;
									valid_bytes_L2 <= {(4*L2_b){1'b1}}; // write all bytes
									set_dirty		  <= 1'b0;
								end else begin
									// the only other case is an evac from below
									write_data_L2[(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b] <= read_data_L1; // todo: this is iffy, test it
									valid_bytes_L2 <= {(4*L2_b){1'b0}};
									valid_bytes_L2[(block_offset_in_adrs_L2*4) +: 4*L1_b] <= {(4*L2_b){1'b1}}; // todo: test this
									set_dirty		  <= 1'b1; // an evac from below only happens if dirty
								end

								// todo: bookmark

								op 			     <= `write_op;
								mem_operation[2]    <= 1'b1;

								set_use			  <= 1'b1;

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
									state <= write_needed_main ? write_Main_st : write_done_st;

									sub_state <= init;
								end
							end
						endcase
					end

					write_Main_st: begin
						case (sub_state)
							init: begin

								// we only write back to main mem, meaning it only gets evacuations

								if (evac_needed_L2) begin
									o_write_data <= read_data_L2;
									o_valid_bytes <= {(4*L2_b){1'b1}}; // write all bytes
								end else begin
									// the only other case is an evac from L1 right up to Main
									o_write_data[(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b] <= read_data_L1; // todo: this is iffy, test it
									o_valid_bytes <= {(4*L2_b){1'b0}};
									o_valid_bytes[(block_offset_in_adrs_L2*4) +: 4*L1_b] <= {(4*L2_b){1'b1}}; // todo: test this
								end

								op 			     <= `write_op;
								o_mem_operation  <= 1'b1;

								sub_state	     <= busy;
							end
							busy: begin
								if (i_mem_operation_done) begin
									o_mem_operation <= 1'b0;

									sub_state 	  <= finish;
								end
							end
							finish: begin
								if (!i_mem_operation_done) begin
									state <= write_done_st;

									sub_state <= init;
								end
							end
						endcase
					end

					write_done_st: begin
						state <= done_st;
					end

			   endcase
			end

		endcase
	end
end

// modules
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

	.i_op(op),

	.i_address(i_address),

	.i_set_valid(set_valid),
	.i_set_tag(set_tag),
	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

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

	.i_op(op),

	.i_address(i_address),

	.i_set_valid(set_valid),
	.i_set_tag(set_tag),
	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

	.i_mem_operation(mem_operation[2]),

	.o_hit_occurred(hit_occurred[2]),
	.o_empty_found(empty_found[2]),
	.o_clean_found(clean_found[2]),

	.i_valid_bytes(valid_bytes_L2),

	.i_write_data(write_data_L2),
	.o_read_data(read_data_L2),

	.o_mem_operation_done(mem_operation_done[2])
);
endmodule
