`timescale 1us / 1ns

module cache
#(
	parameter C = 8,   // capacity (words)
	parameter b = 2,   // block size
	parameter N = 2    // degree of associativity
)
(
	input       		i_clk, 
	input         		i_rst,

	input 				i_mem_write,
	input		  [31:0]	i_address,

	input  	  [7:0] 	i_write_data,
	output reg [7:0]	o_read_data,

	input 				i_mem_operation,
	output reg			o_mem_operation_done,
	output reg  		o_success // #note003
);

	localparam B = C/b;  // number of blocks
	localparam S = B/N;  // number of sets

	localparam Byte_offset_nbytes = $clog2(4);
	localparam Block_offset_nbytes = $clog2(b);
	localparam Set_nbytes = $clog2(S);
	localparam Tag_nbytes = 32 - Set_nbytes - Block_offset_nbytes - Byte_offset_nbytes;
	localparam Use_bit	 = N > 1;

	reg [7:0] 				data_mem  [N-1:0] [S-1:0] [b-1:0] [3:0];
	reg [Tag_nbytes-1:0] tag_mem   [N-1:0] [S-1:0];
	reg 						valid_mem [N-1:0] [S-1:0];
	reg 						dirty_mem [N-1:0] [S-1:0];
	reg 						use_mem   			[S-1:0];

	// todo: check if should do -1
	wire [Byte_offset_nbytes-1:0]  byte_offset_adrs  =	i_address[						 0 +:	Byte_offset_nbytes-1		]; 
	wire [Block_offset_nbytes-1:0] block_offset_adrs = i_address[Byte_offset_nbytes	+:	Block_offset_nbytes-1	];
	wire [Set_nbytes-1:0] 			 set_adrs 			 =	i_address[Block_offset_nbytes	+:	Set_nbytes-1				];
	wire [Tag_nbytes-1:0] 			 tag_adrs 			 =	i_address[Set_nbytes				+:	Tag_nbytes-1				];

	// N operations
	integer i;
	localparam size_N = $clog2(N);

	reg [size_N-1:0] hit_N; // which of the N-ways the hit occurred in
	reg hit_occurred; // validates hit_N
	reg [size_N-1:0] empty_N; // which of the N-ways is empty
	reg empty_found; // validates empty_N
	reg [size_N-1:0] clean_N;
	reg clean_found; // validates clean_N

	wire write_conflict = !hit_occurred && !empty_found;
	wire [size_N-1:0] random_N; // randomly generated N with LFSR
	LFSR #(.size(size_N)) rand_gen (.i_clk(i_clk), .i_rst(i_rst), .o_num(random_N));
	wire target_N = hit_occurred ? hit_N : empty_found ? empty_N : {random_N[size_N-1:1], use_mem [set_adrs]}; // final N #note0001
	reg hit_check_done;

	// internal state
	reg [$clog2(4)-1:0] state;
	localparam 
		idle_st 		= 0,
		lookup_st 	= 1,
		write_st 	= 2,
		read_st 		= 3,
		fail_st		= 4,
		success_st	= 5;

	reg rw_done;
 
	always @(*) begin
		if(i_rst) begin 
			state = 0;
		end
		else begin
			case (state)

				idle_st: begin
					if (i_mem_operation) state = lookup_st;
				end

				lookup_st: begin
					if (hit_check_done) begin
						state = i_mem_write ? 
							write_conflict ? fail_st : write_st : 
							hit_occurred ? read_st : fail_st;
					end
				end

				// read_st: // handled elsewhere
				// write_st: // handled elsewhere

				fail_st: begin
					// more logic elsewhere
					if (!i_mem_operation) state = idle_st;
				end
				success_st: begin
					// more logic elsewhere
					if (!i_mem_operation) state = idle_st;
				end

			endcase
		end
	end

	// hit check
	always @(*) begin
		if (i_rst || i_mem_operation) begin

			hit_check_done = 1'b0;

			hit_occurred = 1'b0;
			empty_found  = 1'b0;
			clean_found  = 1'b0;

			hit_N   = {size_N{1'b0}};
			empty_N = {size_N{1'b0}};
			clean_N = {size_N{1'b0}};

			i = 0;

		end else if (state == lookup_st && !hit_check_done) begin
			#200;
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

			hit_check_done = 1'b1;
		end
	end

	// clocked read/write operations
	always @(posedge i_clk) begin : read_write
		integer i0;
		integer i1;
		integer i2;
		integer i3;
		if (i_rst) begin

			rw_done <= 0;

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
			if (state == write_st) begin
				#20000
				data_mem  [target_N][set_adrs][block_offset_adrs][byte_offset_adrs] <= i_write_data; 
				valid_mem [target_N][set_adrs] <= 1;
				dirty_mem [target_N][set_adrs] <= 1;
				use_mem	   		  [set_adrs] <= !use_mem [set_adrs]; // inverted on write

				rw_done <= 1'b1;
			end

			////////////////////////////////////// read
			if (state == read_st) begin
				#20000
				o_read_data <= data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];

				rw_done <= 1'b1;
			end

		end
	end

	// success and fail states
	always @(*) begin
		if (i_rst) begin
				o_mem_operation_done = 1'b0;
				o_success 				= 1'b0;
		end else begin
			if (state == success_st) begin
				o_mem_operation_done = 1'b1;
				o_success 				= 1'b1;
			end else if (state == fail_st) begin
				o_mem_operation_done = 1'b1;
				o_success 				= 1'b0;
			end
		end
	end
endmodule


// todo: test
module LFSR
#(
	size = 4
) (
	input i_clk, i_rst, 
	output reg [size-1:0] o_num
);
	always@(posedge i_clk) begin
		if(i_rst) o_num <= {size{1'b1}};
		else o_num = {o_num[size-2:0],(o_num[size-1]^o_num[size-2])};
		// shift left once
		// right-most bit is xor of 2 left-most bits
	end
endmodule
