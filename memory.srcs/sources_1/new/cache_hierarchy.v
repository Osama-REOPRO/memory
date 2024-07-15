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
	output reg				      o_mem_operation_done
	
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

wire mem_operation_done [1:2];


wire [($clog2(L2_b) > 0 ? $clog2(L2_b)-1 : 0) :0] block_offset_in_adrs_L2 = 
		(L2_b <= 1) ? 1'b0 : 
		i_address[2   +: ($clog2(L2_b) > 0) ? $clog2(L2_b) : 1];


integer state;
localparam idle_st				= 0,
			  done_st				= 1,
			  lookup_st				= 2,
			  read_st				= 3,
			  write_st				= 4;

integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

integer lookup_sub_state = 0;
integer read_sub_state = 0;
integer write_sub_state = 0;

integer i;

always @(posedge i_clk) begin
	if(i_rst) begin
		state 	 <= 0;
		sub_state <= 0;

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
			mem_operation[2] } = 0;

	end else begin
		case (state)

			idle_st: begin
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

			lookup_st: begin
				localparam lookup_L1_st   = 0,
							  lookup_L2_st	  = 1,
							  lookup_done_st = 2;

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
				localparam read_L1_st   = 0,
							  read_L2_st	= 1,
							  read_done_st = 2;

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

									state		  <= read_needed_L2 ? read_L2_st : read_done_st;
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
								valid_bytes_L1 <= {(4*L1_b){1'b1}}; // how about all valid? while reading that it

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
									state		  <= read_needed_Main ? read_Main_st : read_done_st;
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
								o_valid_bytes <= {(4*L1_b){1'b1}}; // how about all valid? while reading that it

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
									state		  <= read_done_st;
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
				// todo
			end

		endcase
	end
end
wire evac_needed_L1 = !hit_occurred[1] && !empty_found[1]; // read existing value to evacuate it, works for a read op or write op
wire evac_needed_L2 = evac_needed_L1 && !hit_occurred[2] && !empty_found[2]; // read existing value to evacuate it, works for a read op or write op
wire read_needed_L1 = evac_needed_L1 || (hit_occurred[1] && i_op == `read_op);
wire read_needed_L2 = evac_needed_L2 || hit_occurred[2];
wire read_needed_Main = ((i_op == `read_op) && !hit_occurred[1] && !hit_occurred[2]) || evac_needed_L2 || (evac_needed_L1 && !hit_occurred[2]);
endmodule
