`timescale 1us / 1ns

module cache
#(
	parameter I_C = 8,   // capacity (words)
	parameter I_b = 2,   // block size
	parameter I_N = 2,    // degree of associativity


	// snap to powers of 2
	localparam C  = $rtoi($pow(2,$clog2(I_C))),   // capacity (words)
	localparam b  = I_b > C ? C : $rtoi($pow(2,$clog2(I_b))),   // block size (in words)
	localparam B  = C/b,  // number of blocks

	localparam N  = I_N > B ? B : $rtoi($pow(2,$clog2(I_N))),   // degree of associativity
	localparam S  = B/N  // number of sets
)
(
	input       			   i_clk, 
	input         			   i_rst,

	input 	  [op_N:0]	   i_op, // lookup, read, write
	input		  [31:0]		   i_address,

	input 	  [(4*b)-1:0]  i_sel, 			  // valid bytes
	output 	  [(4*b)-1:0]  o_sel, 			  // valid bytes

	output reg [(32*b)-1:0] o_read_data,
	input 	  [(32*b)-1:0] i_write_data,

	input 					   i_mem_operation,
	output reg				   o_mem_operation_done,

	output reg  			   o_conflict,
	output reg  			   o_word_missing
);

	localparam Single_word_blocks  = (b <= 1); // no block offset
	localparam Direct_mapped       = (N <= 1); // don't utilize use_bit

	localparam Byte_offset_nbytes  = 2; // offset of byte within word
	localparam Block_offset_nbytes = $clog2(b); // offset of word within block (more like word_offset)
	localparam Set_nbytes 			 = $clog2(S);
	localparam Tag_nbytes 			 = 32 - Set_nbytes - Block_offset_nbytes - Byte_offset_nbytes;

	integer t;
	initial begin
		$display("\n\n////////////////////////// parameters ////////////////////////////////////");
		$display(); // new line

		$display("C = 2^(clog2(%0d)) = 2^%0d = %0d", I_C, $clog2(I_C), $pow(2,$clog2(I_C)));
		$display("b = 2^(clog2(%0d)) = 2^%0d = %0d", I_b, $clog2(I_b), $pow(2,$clog2(I_b)));
		$display("N = 2^(clog2(%0d)) = 2^%0d = %0d", I_N, $clog2(I_N), $pow(2,$clog2(I_N)));
		$display();
		// for(t=0;t<100;t=t+1) $display("parameter = 2^(clog2(%3d)) = 2^%3d = %3d", t, $clog2(t), $pow(2,$clog2(t)));
		$display();

		$write  ("block size        b = %0d", b); if (Single_word_blocks) $display(" (Single_word_blocks)"); else $display();
		$write  ("associativity     N = %0d", N); if (Direct_mapped) 		$display(" (Direct_mapped)"); 	  else $display();
		$display(); // new line

		$display("capacity (words)  C = %0d", C); 
		$display("number of blocks  B = %0d", B); 
		$display("number of sets    S = %0d", S); 
		$display(); // new line

		$display("Byte_offset_nbytes  = %0d", Byte_offset_nbytes);
		$display("Block_offset_nbytes = %0d", (Single_word_blocks ? 0 : Block_offset_nbytes));
		$display("Set_nbytes          = %0d", Set_nbytes);
		$display("Tag_nbytes          = %0d", Tag_nbytes);
		$display("sum ------------------- + = %0d", Byte_offset_nbytes + Block_offset_nbytes + Set_nbytes + Tag_nbytes);
		$display("\n");
	end
	
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

	initial begin
		$display("\n////////////////////////// decode address ////////////////////////////////////\n");
		
      $display("byte_offset_adrs  = i_address[%0d +: %2d], absolute [%0d : %2d]", 0,   Byte_offset_nbytes,  																 0, 																			Byte_offset_nbytes - 1);
		if (!Single_word_blocks)
		$display("block_offset_adrs = i_address[%0d +: %2d], absolute [%0d : %2d]", 0 +  Byte_offset_nbytes,  Block_offset_nbytes, 			      	          Byte_offset_nbytes, 													Byte_offset_nbytes + Block_offset_nbytes - 1);
		$display("set_adrs          = i_address[%0d +: %2d], absolute [%0d : %2d]", 0 +  Byte_offset_nbytes + Block_offset_nbytes,  Set_nbytes,     	          Byte_offset_nbytes + Block_offset_nbytes,     					Byte_offset_nbytes + Block_offset_nbytes + Set_nbytes - 1);
		$display("tag_adrs          = i_address[%0d +: %2d], absolute [%0d : %2d]", 0 +  Byte_offset_nbytes + Block_offset_nbytes + Set_nbytes, Tag_nbytes, 	 Byte_offset_nbytes + Block_offset_nbytes + Set_nbytes,     Byte_offset_nbytes + Block_offset_nbytes + Set_nbytes + Tag_nbytes - 1);
		if (Single_word_blocks) $display("(no block offset bits)");
		$display("\n");
	end

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
	reg [$clog2(7)-1:0] state;
	localparam 
		idle_st 		 = 0,
		lookup_st 	 = 1,
		write_st 	 = 2,
		read_st 		 = 3,
		evac_read_st = 4,
		fail_st		 = 5,
		success_st	 = 6;

	always @(*) begin
		if(i_rst) begin 
			state = 0;
		end
		else begin
			case (state)

				idle_st: begin
					if (i_mem_operation) begin
						case (i_op)
							get_state : state = lookup_st;
							read		 : state = write_st;
							write		 : state = write_st;
							default   : state = idle_st;
						endcase
					end
				end

				lookup_st: begin
					if (hit_check_done) begin
						#0.1;
						state = i_mem_write ? 
							write_would_conflict ? evac_read_st : valid_mem [target_N][set_adrs] || i_word_op ? write_st : fail_st : 
							hit_occurred ? read_st : fail_st;
					end
				end

				// read_st: // handled elsewhere
				// write_st: // handled elsewhere
				// evac_read_st: // handled elsewhere

				success_st: begin
					// handled elsewhere
					#0.3
					if (!i_mem_operation) state = idle_st;
				end
				fail_st: begin
					// handled elsewhere
					#0.3
					if (!i_mem_operation) state = idle_st;
				end

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

		end else if (state == lookup_st && !hit_check_done) begin
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

			hit_check_done = 1'b1;
		end else begin
			hit_check_done = 1'b0;
		end
	end

	// clocked read/write operations
	always @(posedge i_clk) begin : read_write
		integer i0;
		integer i1;
		integer i2;
		integer i3;
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
			if (state == write_st) begin
//				#20000
				#20;
				if (i_word_op) begin
					// word write
					data_mem  [target_N][set_adrs][block_offset_adrs][0] <= i_write_data[0*8 +:8];
					data_mem  [target_N][set_adrs][block_offset_adrs][1] <= i_write_data[1*8 +:8];
					data_mem  [target_N][set_adrs][block_offset_adrs][2] <= i_write_data[2*8 +:8];
					data_mem  [target_N][set_adrs][block_offset_adrs][3] <= i_write_data[3*8 +:8];

					tag_mem	 [target_N][set_adrs] <= tag_adrs;
					valid_mem [target_N][set_adrs] <= 1'b1;
					o_word_missing 					 <= 1'b0;
				end else begin
					// byte write
					data_mem  [target_N][set_adrs][block_offset_adrs][byte_offset_adrs] <= i_write_data[7:0];
					// on word write, use the first 8-bits
				end

				dirty_mem [target_N][set_adrs] <= 1;
				use_mem	   		  [set_adrs] <= !use_mem [set_adrs]; // inverted on write

				state <= success_st;
			end

			////////////////////////////////////// read
			if (state == read_st) begin
//				#20000
				#20;
				if (i_word_op) begin
					// word read
					o_read_data[0*8 +:8] <= data_mem[hit_N][set_adrs][block_offset_adrs][0];
					o_read_data[1*8 +:8] <= data_mem[hit_N][set_adrs][block_offset_adrs][1];
					o_read_data[2*8 +:8] <= data_mem[hit_N][set_adrs][block_offset_adrs][2];
					o_read_data[3*8 +:8] <= data_mem[hit_N][set_adrs][block_offset_adrs][3];
				end else begin
					// byte read
					o_read_data[7:0] <= data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];
					// read only to first 8 bytes
				end

				state <= success_st;
			end

			////////////////////////////////////// evac read
			// read data that should be evacuated for a conflicting write
			if (state == evac_read_st) begin
//				#20000
				#20;
				o_read_data[0*8 +:8] <= data_mem[target_N][set_adrs][block_offset_adrs][0];
				o_read_data[1*8 +:8] <= data_mem[target_N][set_adrs][block_offset_adrs][1];
				o_read_data[2*8 +:8] <= data_mem[target_N][set_adrs][block_offset_adrs][2];
				o_read_data[3*8 +:8] <= data_mem[target_N][set_adrs][block_offset_adrs][3];

				state = fail_st;
			end

		end
	end

	// success and fail states
	always @(*) begin
		if (i_rst) begin
				o_mem_operation_done = 1'b0;
				o_success 				= 1'b0;
		end else begin
			case (state)
				success_st: begin
					o_mem_operation_done = 1'b1;
					o_success            = 1'b1;
				end
				fail_st: begin
					o_mem_operation_done = 1'b1;
					o_success            = 1'b0;
					o_word_missing			= !valid_mem [target_N][set_adrs];
				end
				default: begin
					o_mem_operation_done = 1'b0;
					o_success            = 1'b0;
				end
			endcase
		end
	end
endmodule


// todo: test
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
