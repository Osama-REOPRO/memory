`timescale 1us / 1ns
`include "cache_ops.vh"

module cache
#(
	parameter C = 8,   // capacity (total words)
	parameter b = 2,   // block size (words per block)
	parameter N = 2    // degree of associativity (blocks per set)
)
(
	input       			   	  i_clk, 
	input         			   	  i_rst,

	input 	  [`op_N:0]	   	  i_op, 				// lookup, read, write
	input		  [31:0]		   	  i_address,

	input 							  i_set_dirty,
	input 							  i_set_use,

	input 					   	  i_mem_operation,

	output reg 						  o_hit_occurred,
	output reg 						  o_empty_found,
	output reg  			   	  o_clean_found,

	input 	  [$clog2(4*b)-1:0] i_n_bytes, 	// number of bytes in read/write data

	input 	  [(32*b)-1:0] 	  i_write_data,
	output reg [(32*b)-1:0] 	  o_read_data,

	output reg				   	  o_mem_operation_done
);
	// parameters
	localparam B  = C/b;  // number of blocks
	localparam S  = B/N;  // number of sets

	localparam Single_word_blocks  = (b <= 1); // no block offset
	localparam Direct_mapped       = (N <= 1); // don't utilize use_bit

	localparam Byte_offset_nbytes  = 2; // offset of byte within word
	localparam Block_offset_nbytes = $clog2(b); // offset of word within block (more like word_offset)
	localparam Set_nbytes 			 = $clog2(S);
	localparam Tag_nbytes 			 = 32 - Set_nbytes - Block_offset_nbytes - Byte_offset_nbytes;
	
	// mem
	reg [7:0] 				data_mem  [N-1:0] [S-1:0] [b-1:0] [3:0];
	reg [Tag_nbytes-1:0] tag_mem   [N-1:0] [S-1:0];
	reg 						valid_mem [N-1:0] [S-1:0];
	reg 						dirty_mem [N-1:0] [S-1:0];
	reg 						use_mem   			[S-1:0];

	// decode address
	wire [Byte_offset_nbytes-1:0]  											 byte_offset_adrs  =										 i_address[0 +: Byte_offset_nbytes ];
	wire [(Block_offset_nbytes > 0 ? Block_offset_nbytes-1 : 0) :0] block_offset_adrs = Single_word_blocks ? 1'b0 : i_address[0 +  Byte_offset_nbytes +: Block_offset_nbytes > 0 ? Block_offset_nbytes : 1]; // just so it will compile, not used when Single_word_blocks
	wire [Set_nbytes-1:0] 			 											 set_adrs 			 =										 i_address[0 +  Byte_offset_nbytes +  Block_offset_nbytes	+:	Set_nbytes ];
	wire [Tag_nbytes-1:0] 			 											 tag_adrs 			 =										 i_address[0 +  Byte_offset_nbytes +  Block_offset_nbytes	+	Set_nbytes +: Tag_nbytes ];

	// N operations
	integer i;
	localparam size_N = $clog2(N);

	reg [size_N-1:0] hit_N; // which of the N-ways the hit occurred in
	reg hit_occurred; // validates hit_N
	reg [size_N-1:0] empty_N; // which of the N-ways is empty
	reg empty_found; // validates empty_N
	reg [size_N-1:0] clean_N;
	reg clean_found; // validates clean_N

	wire [size_N-1:0] random_N; // randomly generated N with LFSR
	LFSR #(.size(size_N)) rand_gen (.i_clk(i_clk), .i_rst(i_rst), .o_num(random_N));
	wire target_N = Direct_mapped ? 0       : 
						 hit_occurred  ? hit_N 	 :
						 empty_found   ? empty_N :
						 clean_found   ? clean_N :
						 {random_N[size_N-1:1], use_mem [set_adrs]}; // N to evacuate then replace #note0001

	reg hit_check_done;
	wire write_would_conflict = !hit_occurred && !empty_found && !clean_found;

	// state machine
	reg [$clog2(3)-1:0] state;
	localparam 
		idle_st 	 = 0,
		busy_st 	 = 1,
		done_st 	 = 2;

	reg op_done;
	always @(*) if (state == idle_st) op_done = 1'b0;

	always @(*) begin
		if(i_rst) begin 
			state = 0;
		end
		else begin
			case (state)
				idle_st: if (i_mem_operation)  state = busy_st;
				busy_st: if (op_done) 			 state = done_st;
				done_st: if (!i_mem_operation) state = idle_st;
			endcase
		end
	end

	// hit check
	always @(*) begin
		if (i_rst) begin

			hit_check_done = 1'b0;

			hit_occurred = 1'b0;
			empty_found  = 1'b0;
			clean_found  = 1'b0;

			hit_N   = {size_N{1'b0}};
			empty_N = {size_N{1'b0}};
			clean_N = {size_N{1'b0}};

			i = 0;

		end else if (state == busy_st && i_op == `lookup_op) begin
			hit_occurred = 1'b0;
			clean_found  = 1'b0;
			empty_found  = 1'b0;
			#10;
			for (i=0; i<N; i=i+1) begin
				if (valid_mem[i][set_adrs]) begin
					if (tag_adrs == tag_mem[i][set_adrs]) begin
						hit_occurred = 1'b1;
						hit_N = i;
					end else if (!dirty_mem[i][set_adrs]) begin
						clean_found  = 1'b1;
						clean_N = i;
					end
				end else begin
					empty_found = 1'b1;
					empty_N = i;
				end
			end
		end

		op_done = 1'b1;
	end

	// clocked read/write operations
	always @(posedge i_clk) begin : read_write
		integer i0;
		integer i1;
		integer i2;
		integer i3;
		reg [$clog2(4*b)-1:0] ib; 	// number of bytes in write_data
		if (i_rst) begin

			o_word_missing <= 0;

			for (i0=0; i0<N; i0=i0+1) begin
				for (i1=0; i1<S; i1=i1+1) begin

					tag_mem	 [i0][i1] <= 0;
					valid_mem [i0][i1] <= 0;
					dirty_mem [i0][i1] <= 0;
					use_mem       [i1] <= 0;

					for (i2=0; i2<b; i2=i2+1) begin
						for (i3=0; i3<4; i3=i3+1) begin

							data_mem[i0][i1][i2][i3] <= 0;

						end
					end
				end
			end
		end else begin
			////////////////////////////////////// write
			if (state == busy_st && i_op == `write_op) begin
				#20;

				for (ib=0; ib<i_n_bytes; ib=ib+1) begin
						data_mem  				[target_N][set_adrs][ ib[$clog2(4*b)-1:2] ][ ib[1:0] ] <= i_write_data[ib*8 +:8];
				end

				if (i_n_bytes == $clog2(4*b)) begin
					valid_mem 					[target_N][set_adrs] <= 1'b1;
					tag_mem	 					[target_N][set_adrs] <= tag_adrs;
				end

				if (i_set_dirty) dirty_mem [target_N][set_adrs] <= 1'b1;
				if (i_set_use)   use_mem 				 [set_adrs] <= !use_mem [set_adrs]; // inverted on write

				op_done <= 1'b1;
			end

			////////////////////////////////////// read
			if (state == busy_st && i_op == `read_op) begin
				#20;
				for (ib=0; ib<i_n_bytes; ib=ib+1) begin
					o_read_data[ib*8 +:8] <= data_mem[hit_N][set_adrs][ ib[$clog2(4*b)-1:2] ][ ib[1:0] ];
				end

				op_done <= 1'b1;
			end
		end
	end

// LFSR
module LFSR
#(
	parameter size = 4,
	localparam clamped_size = size >= 4 ? size : 4 // LFSR makes no sense under 4-bits
) (
	input i_clk, i_rst, 
	output reg [clamped_size-1:0] o_num
);
	always@(posedge i_clk) begin
		if(i_rst) o_num <= {clamped_size{1'b1}};
		else o_num = {o_num[clamped_size-2:0],(o_num[clamped_size-1]^o_num[clamped_size-2])};
		// shift left once
		// right-most bit is xor of 2 left-most bits
	end
endmodule
