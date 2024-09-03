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
	output 	  [31:0]		   	o_address,

	output reg [(4*L2_b)-1:0]  o_valid_bytes,

	output reg [(32*L2_b)-1:0] o_write_data,
	input		  [(32*L2_b)-1:0] i_read_data,

	output reg			   	   o_mem_operation,
	input								i_mem_operation_done
);

assign o_address = i_address;

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

// address we get when we lookup (conflicting address)
// this is the address that later read/write operations will target
wire [31:0] adrs_target_N_L1; 
wire [31:0] adrs_target_N_L2;
wire target_N_L2; // one bit because N=2, so only 2 states

//wire [(L1_N*32)-1:0] adrs_N_tags_L1; // same as adrs_target_N_L1
wire [L1_N-1:0] 		adrs_N_valids_L1;
wire [L1_N-1:0] 		adrs_N_dirtys_L1;
wire 						adrs_N_use_L1;

wire [(L2_N*32)-1:0] adrs_N_tags_L2;
wire [L2_N-1:0] 		adrs_N_valids_L2;
wire [L2_N-1:0] 		adrs_N_dirtys_L2;
wire 						adrs_N_use_L2;
// addresses for each N in L2
wire [31:0] L2_N1_tag = adrs_N_tags_L2[31:0];
wire [31:0] L2_N2_tag = adrs_N_tags_L2[63:32];
localparam Tag_nbytes = 32 - $clog2((L2_C/L2_b)/L2_N) - $clog2(L2_b) - 2; // used for extracting the tag part

reg use_manual_adrs;
reg [31:0] adrs_manual;
reg use_manual_N;
reg [1:0] manual_N;

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

wire write_needed_L2_from_main = both_missed;
wire conflict_occurred_L2 = write_needed_L2_from_main && !hit_occurred[2] && !empty_found[2];
wire evac_needed_L2 = conflict_occurred_L2 && (!clean_found[2] || evac_needed_L1);
	// if a conflict occurs and either clean not found or L1 needs an evac, because if
	// L1 needs an evac it doesn't matter that a clean was found because we need to
	// write twice, one clean isn't enough

wire read_needed_L1 = (is_read_op && hit_occurred[1]) || evac_needed_L1;
wire read_needed_L2 = only_second_hit || evac_needed_L2;
// you only need to read it in 2 cases:
// - read when hit and lower miss to write to lower level
// - read to evac to higher level

wire read_needed_Main = both_missed;
wire write_needed_main = evac_needed_L2;

wire evac_needed_both = evac_needed_L1 && evac_needed_L2;
wire write_needed_L2_evac = evac_needed_L1; // todo: verify

wire [($clog2(L2_b) > 0 ? $clog2(L2_b)-1 : 0) :0] block_offset_in_adrs_L2 = 
		(L2_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(L2_b) > 0) ? $clog2(L2_b) : 1];


// state machine
integer state;
integer next_state;
localparam idle_st					= 0,
			  lookup_L1_st	  			= 1,
			  lookup_L2_st	  			= 2,
			  read_L1_st    			= 3,
			  read_L2_st    			= 4,
			  read_Main_st  			= 5,
			  write_L1_st   			= 6,
			  write_L2_from_main_st = 7,
			  write_L2_from_L1_st  	= 8,
			  write_Main_st			= 9,
			  done_st					= 10;

integer cache_sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

always @(*) begin
	if (i_rst) begin
		next_state = 0;
	end else begin
		case (state)
			idle_st: begin
				if (i_mem_operation) next_state = lookup_L1_st;
				else next_state = idle_st; // latch prevent
			end
			lookup_L1_st: begin
				if (hit_occurred[1]) next_state = is_read_op ? read_L1_st : write_L1_st; 
				else next_state = lookup_L2_st;
			end
			lookup_L2_st: begin
				next_state = 
					read_needed_L1 	? read_L1_st :
					read_needed_L2 	? read_L2_st :
					read_needed_Main 	? read_Main_st :
					write_needed_L1 		? write_L1_st :
					write_needed_L2_from_main 		? write_L2_from_main_st :
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			read_L1_st: begin
				next_state = 
					read_needed_L2 	? read_L2_st :
					read_needed_Main 	? read_Main_st :
					write_needed_L1 		? write_L1_st :
					write_needed_L2_from_main 		? write_L2_from_main_st :
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			read_L2_st: begin
				next_state = 
					read_needed_Main 	? read_Main_st :
					write_needed_L1 		? write_L1_st :
					write_needed_L2_from_main 		? write_L2_from_main_st :
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			read_Main_st: begin
				next_state = 
					write_needed_L1 		? write_L1_st :
					write_needed_L2_from_main 		? write_L2_from_main_st :
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			write_L1_st: begin
				next_state = 
					write_needed_L2_from_main 		? write_L2_from_main_st :
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			write_L2_from_main_st: begin
				next_state = 
					write_needed_L2_evac ? write_L2_from_L1_st :
					write_needed_main 	? write_Main_st :
						done_st;
			end
			write_L2_from_L1_st: begin
				next_state = 
					write_needed_main 	? write_Main_st :
						done_st;
			end
			write_Main_st: begin
				next_state = done_st;
			end
			done_st: begin
				if (!i_mem_operation) next_state = idle_st;
				else next_state = done_st;
			end
		endcase
	end
end


integer i;
// reg non_current_adrs_lookup_occurred_L2; // could use this to make sure no errors occur after that lookup

always @(posedge i_clk) begin
	if(i_rst) begin
		i <= 0;
		state 	 <= 0;
		cache_sub_state <= 0;

		{ 	valid_bytes_L1,
			valid_bytes_L2,
									
			write_data_L1,
			write_data_L2,

			set_valid,
			set_tag,
			set_dirty,
			set_use,

			op,

			mem_operation[1],
			mem_operation[2],
			o_op,
			o_valid_bytes,
			o_write_data,
			o_mem_operation,

			use_manual_adrs,
			adrs_manual,
			use_manual_N,
			manual_N

			// non_current_adrs_lookup_occurred_L2
			} = 0;

	end else begin
		case (state)

			idle_st: begin
				o_mem_operation_done <= 1'b0;
				state <= next_state;
			end

			done_st: begin
				o_mem_operation_done = 1'b1;
				state <= next_state;
			end

			lookup_L1_st: begin
				case (cache_sub_state)
					init: begin
						op			  <= `lookup_op;
						mem_operation[1] <= 1'b1;

						cache_sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							state <= next_state;
							cache_sub_state <= init;
						end
					end
				endcase
			end

			lookup_L2_st: begin
				case (cache_sub_state)
					init: begin
						op			  <= `lookup_op;
						mem_operation[2] <= 1'b1;

						use_manual_adrs <= 1'b0; // always lookup current address

						cache_sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							state <= next_state;
							cache_sub_state  <= init;
						end
					end
				endcase
			end

			read_L1_st: begin
				case (cache_sub_state)
					init: begin
						op 			   <= `read_op;
						mem_operation[1]  <= 1'b1;
						valid_bytes_L1 <= {(4*L1_b){1'b1}}; // how about all valid? while reading that it

						cache_sub_state		<= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							// o_read_data <= read_data_L1; // todo: assign read_data
							state <= next_state;
							cache_sub_state  <= init;
						end
					end
				endcase
			end

			read_L2_st: begin
				case (cache_sub_state)
					init: begin
						op 			   <= `read_op;
						mem_operation[2]  <= 1'b1;
						valid_bytes_L2 <= {(4*L2_b){1'b1}}; // how about all valid? while reading that it

						if (evac_needed_L1) begin
							use_manual_adrs <= 1'b1;
							adrs_manual <= adrs_target_N_L1;
							use_manual_N <= 1'b1;
							manual_N <= (L2_N1_tag[31 -:Tag_nbytes] == adrs_target_N_L1[31 -:Tag_nbytes]) ? 1 : 0; // N not evac target
						end else begin
							use_manual_adrs <= 1'b0;
							use_manual_N <= 1'b0;
						end

						cache_sub_state		<= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							use_manual_adrs <= 1'b0;
							use_manual_N <= 1'b0;
							state <= next_state;
							cache_sub_state  <= init;
						end
					end
				endcase
			end

			read_Main_st: begin
				case (cache_sub_state)
					init: begin
						o_op 			   <= `read_op;
						o_mem_operation  <= 1'b1;
						o_valid_bytes <= {(4*L2_b){1'b1}}; // how about all valid? while reading that it

						cache_sub_state		<= busy;
					end
					busy: begin
						if (i_mem_operation_done) begin
							o_mem_operation <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!i_mem_operation_done) begin
							cache_sub_state  <= init;
							state <= next_state;
						end
					end
				endcase
			end


			write_L1_st: begin
				case (cache_sub_state)
					init: begin

						if (hit_occurred[1]) begin
							// only happens if write_op and hit
							write_data_L1  <= i_write_data; // write directly
							valid_bytes_L1 <= i_valid_bytes; // write only some bytes not all
							// note: no need to differentiate betrween read_op
							// and write_op in the case where a hit occurred on
							// L1, because if a hit had occurred on L1 and it
							// is a read_op then we wouldn't have entered the 
							// write state to begin with, if it was a write_op
							// then we directly write which is what we are
							// doing here

						end else if (hit_occurred[2]) begin
							valid_bytes_L1 <= {(4*L1_b){1'b1}}; // overwrite all bytes
							case (i_op)
								`read_op: begin
									write_data_L1 <= read_data_L2[i_address[3]*64 +: 64];
									// todo: check if this works
									// this complication is because we can't just always use the lower part of the data from L2, 
									// because what if the data we want isn't in the lower part but the middle one or upper one? 
									// I need to change what part of it I get based on address
								end
								`write_op: begin
									// combine data read from 2nd level with new data coming from input
									for (i=0; i<(4*L1_b); i=i+1) begin // step through byte by byte
										write_data_L1[(i*8)-1 +: 8] <= i_valid_bytes[i] ?
											i_write_data[(i*8)-1 +: 8] : read_data_L2[((i+(i_address[3]*8))*8)-1 +: 8];
									end
								end
							endcase
						end else begin
							// data must have been fetched from main memory
							valid_bytes_L1 <= {(4*L1_b){1'b1}}; // overwrite all bytes
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
						mem_operation[1] <= 1'b1;

						set_valid	<= 1'b1;
						set_dirty  	<= 1'b1;
						set_use	  	<= 1'b1;
						set_tag 		<= 1'b1;

						cache_sub_state   <= busy;
					end
					busy: begin
						if (mem_operation_done[1]) begin
							mem_operation[1] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[1]) begin
							// todo: verify this

							// in second cache we write in these cases:
							// - evac dirty from below
							// 		happens on both reads and writes
							// - fill missing from above
							// 		happens on both reads and writes on miss both

							// sub_state <= 
							// !write_needed_L2 ? write_done_st :
							// hit_occurred[2] ? lookup_L2_second_st :  // if L2 did hit, then this must be an evacuation from L1
							// 													  // we always do a second lookup to get the 
							// 													  // correct N to write to
							// 						write_L2_from_main_st; // if we missed, then the data must come from above,
							// 													  // but we might need to do an evacuation later from below
							// 													  // to a different N (determined at end)

							state <= next_state;
							cache_sub_state <= init;
						end
					end
				endcase
			end

			write_L2_from_L1_st: begin
				case (cache_sub_state)
					init: begin

						use_manual_adrs <= 1'b1;
						adrs_manual <= adrs_target_N_L1;
						use_manual_N <= 1'b1;
						manual_N <= (L2_N1_tag[31 -:Tag_nbytes] == adrs_target_N_L1[31 -:Tag_nbytes]) ? 0 : 1; // choose N with same address

						write_data_L2[i_address[3]*64 +: 64] <= read_data_L1;
						valid_bytes_L2[i_address[3]*8 +: 8]  <= {8'hff}; // this doesn't seem right, not sure why sim is working properly
						valid_bytes_L2[!i_address[3]*8 +: 8] <= {8'h00};
						set_dirty		  <= 1'b1;

						op 			     <= `write_op;
						mem_operation[2]    <= 1'b1;

						set_use			  <= 1'b0;
						set_valid	<= 1'b1;

						cache_sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							use_manual_adrs <= 1'b0;
							use_manual_N <= 1'b0;

							state <= next_state;
							cache_sub_state <= init;
						end
					end
				endcase
			end

			write_L2_from_main_st: begin
				case (cache_sub_state)
					init: begin

						if (evac_needed_L2) begin
							use_manual_N <= 1'b1;
							manual_N <= (L2_N1_tag[31 -:Tag_nbytes] == adrs_target_N_L1[31 -:Tag_nbytes]) ? 1 : 0; // we want to avoid writing to evac target
						end

						use_manual_adrs <= 1'b0;

						write_data_L2 <= i_read_data;
						valid_bytes_L2 <= {(4*L2_b){1'b1}}; // write all bytes
						set_dirty		  <= 1'b0;

						op 			     <= `write_op;
						mem_operation[2]    <= 1'b1;

						set_use			  <= 1'b1;
						set_valid	<= 1'b1;

						cache_sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							use_manual_N <= 1'b0;
							state <= next_state;
							cache_sub_state <= init;
						end
					end
				endcase
			end


			write_Main_st: begin
				case (cache_sub_state)
					init: begin

						// we only write back to main mem, meaning it only gets evacuations
						// question: what if both need evacuation?
						// answer: remember that we are using inclusive policy, meaning that we can't have two different
						// 			pieces of data that need to be evacuated, we know that if a piece of data exists in 
						// 			lower cache then it must also exist in higher cache, so if we need an evacuation from
						// 			both then we have two cases: if the lower is dirty then we combine it's data with the 
						//				upper data and write the combination to main, if clean we only write higher cache data
						// 			and ignore the lower, there is not situation in which we need 2 write operations
						// assumption: we never have a situation in which we evacuate the same piece of data from L1 and 
						// 	from L2, that is because what is in L1 must be more recent that what isn't in L1, so what 
						// 	is in L1 gets evacced to L2, and what is in L2 but not in L1 gets evacced to main

						o_write_data <= read_data_L2;
						o_valid_bytes <= {(4*L2_b){1'b1}}; // write all bytes

						o_op 			     <= `write_op;
						o_mem_operation  <= 1'b1;

						cache_sub_state	     <= busy;
					end
					busy: begin
						if (i_mem_operation_done) begin
							o_mem_operation <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!i_mem_operation_done) begin
							state <= next_state;
							cache_sub_state <= init;
						end
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

	.i_address(use_manual_adrs ? adrs_manual : i_address),

	.i_set_valid(set_valid),
	.i_set_tag(set_tag),
	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

	.i_use_manual_N(1'b0),
	.i_manual_N(1'b0),

	.i_mem_operation(mem_operation[1]),

	.o_hit_occurred(hit_occurred[1]),
	.o_empty_found(empty_found[1]),
	.o_clean_found(clean_found[1]),
	.o_adrs(adrs_target_N_L1),
	.o_target_N(), // always 0

	.o_adrs_N_tags(), // not connected because single N so same as adrs_target_N_L1
	.o_adrs_N_valids(adrs_N_valids_L1),
	.o_adrs_N_dirtys(adrs_N_dirtys_L1),
	.o_adrs_N_use(adrs_N_use_L1),

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

	.i_address(use_manual_adrs ? adrs_manual : i_address),

	.i_set_valid(set_valid),
	.i_set_tag(set_tag),
	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

	.i_use_manual_N(use_manual_N),
	.i_manual_N(manual_N),

	.i_mem_operation(mem_operation[2]),

	.o_hit_occurred(hit_occurred[2]),
	.o_empty_found(empty_found[2]),
	.o_clean_found(clean_found[2]),
	.o_adrs(adrs_target_N_L2),
	.o_target_N(target_N_L2),

	.o_adrs_N_tags(adrs_N_tags_L2),
	.o_adrs_N_valids(adrs_N_valids_L2),
	.o_adrs_N_dirtys(adrs_N_dirtys_L2),
	.o_adrs_N_use(adrs_N_use_L2),

	.i_valid_bytes(valid_bytes_L2),

	.i_write_data(write_data_L2),
	.o_read_data(read_data_L2),

	.o_mem_operation_done(mem_operation_done[2])
);
endmodule
