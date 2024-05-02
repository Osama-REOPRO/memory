`timescale 1us / 1ns

// memory system states
`define ready_st_mem_sys 0
`define busy_st_mem_sys 1
`define valid_st_mem_sys 2
`define prep_st_mem_sys 3

`define memory_system_state_reg_len 4

// cache states
`define valid_st_cache 			0
`define write_done_st_cache 	1
`define read_miss_st_cache		2
`define read_hit_st_cache		3
`define disconnected_st_cache 4

`define cache_state_reg_len 4

module tb;
reg  			clk, rst;
reg  			mem_operation;
reg  			mem_write;
reg  [31:0] address;
reg  [7:0]  write_data;
wire [7:0]  read_data;
wire 			mem_operation_done;

always #0.1 clk <= !clk; // clock runs at 10 MHz
integer valToWrite = 1;
	integer adrsToWrite = 1;
	integer state = 0;
	localparam idle_st = 0, read_init_st = 1, await_read_st = 2, write_init_st = 3, await_write_st = 4;

	always @(posedge clk) begin
		if(rst) begin
			mem_operation <= 0;
			mem_write <= 0;
			address <= 0;
			write_data <= 0;
			valToWrite <= 0;
			adrsToWrite <= 0;
			state <= 0;
		end else begin
			case (state)
				idle_st: begin
					state = write_init_st;
				end
				read_init_st: begin
					mem_operation = 1;
					mem_write = 0;
					address = adrsToWrite - 1;
					state = await_read_st;
				end
				await_read_st: begin
					if (mem_operation_done) begin
						mem_operation = 0;
						valToWrite = read_data+1;
						state = write_init_st;
					end
				end
				write_init_st: begin
					mem_operation = 1;
					mem_write = 1;
					address = adrsToWrite;
					write_data = valToWrite;
					state = await_write_st;
				end
				await_write_st: begin
					if (mem_operation_done) begin
						mem_operation = 0;
						adrsToWrite = adrsToWrite + 1;
						state = read_init_st;
					end
				end
			endcase
		end
	end


	memory mem (
		.i_clk(clk),
		.i_rst(rst),
		.i_mem_operation(mem_operation),
		.o_mem_operation_done(mem_operation_done),
		.i_mem_write(mem_write),
		.i_address(address),
		.i_write_data(write_data),
		.o_read_data(read_data)
	);
	initial begin
		{clk, mem_operation, mem_write, address, write_data} = 0;
		rst = 1;
		#1
		rst = 0;
	end
endmodule

module memory(
	input         i_clk, 
	input         i_rst,

	input  		  i_mem_write,
	input	 [31:0] i_address,
	input  [7:0]  i_write_data,

	input         i_mem_operation,

	output [7:0]  o_read_data,
	output        o_mem_operation_done
);
	
	localparam 
		idle_st 			  = 0, 
		get_data_st 	  = 1, 
		evac_st 			  = 2, 
		write_missing_st = 3;
	reg [$clog2(4)-1:0] state;
	always @(*) begin
		if (i_rst) state = 0;
		else begin
			case (state)
				idle_st: begin
					if (i_mem_operation && !i_mem_write) state = get_data_st;
				end
				get_data_st: begin
					if (hit_occurred) state = miss_occurred ? (evac_needed ? evac_st : write_missing_st) : idle_st; // todo: add missing stuff
				end
				evac_st: begin
				end
				write_missing_st: begin
				end
			endcase
		end
	end
	// L0 cache parameters
	wire mem_write_higher_0;
	wire address_higher_0;

	wire write_data_higher_0;
	wire read_data_higher_0;

	wire mem_operation_higher_0;
	wire mem_operation_higher_done_0;

	// virtual memory parameters
	wire mem_operation_done_virtual_memory;

	//	instantiations
	cache #(.C(8), .b(1), .N(1)) 
	cache_direct_mapped_l_0 (
		.i_clk(i_clk),
		.i_rst(i_rst),

		// interaction with this cache
		.i_mem_write(i_mem_write),
		.i_address(i_address),

		.i_write_data(i_write_data),
		.o_read_data(o_read_data),

		.i_mem_operation(i_mem_operation),
		.o_mem_operation_done(o_mem_operation_done),

		// interaction with higher cache
		.o_mem_write_higher(mem_write_higher_0),
		.o_address_higher(address_higher_0),

		.o_write_data_higher(write_data_higher_0),
		.i_read_data_higher(read_data_higher_0),

		.o_mem_operation_higher(mem_operation_higher_0),
		.i_mem_operation_higher_done(mem_operation_higher_done_0)
	);


	virtual_memory v_mem(
		.i_clk(i_clk),
		.i_rst(i_rst),

		.i_mem_write(mem_write_higher_0),
		.i_address(address_higher_0),

		.i_write_data(write_data_higher_0),
		.o_read_data(read_data_higher_0),

		.i_mem_operation(mem_operation_higher_0),
		.o_mem_operation_done(mem_operation_higher_done_0)
	);


endmodule

module cache
#(
	parameter C = 8,   // capacity (words)
	parameter b = 2,   // block size
	parameter N = 2    // degree of associativity
)
(
	input       		i_clk, 
	input         		i_rst,

	// interaction with this cache
	input 				i_mem_write,
	input		  [31:0]	i_address,

	input  	  [7:0] 	i_write_data,
	output reg [7:0]	o_read_data,

	input 				i_mem_operation,
	output 				o_mem_operation_done,

	// interaction with higher cache
	output reg			o_mem_write_higher,
	output reg [31:0]	o_address_higher,

	output reg [7:0]	o_write_data_higher,
	input      [7:0]	i_read_data_higher,

	output reg			o_mem_operation_higher,
	input 				i_mem_operation_higher_done
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
	reg empty_found; // validates empty_found
	wire write_conflict = !hit_occurred && !empty_found;
	wire [size_N-1:0] random_N; // randomly generated N with LFSR
	LFSR #(.size(size_N)) rand_gen (.i_clk(i_clk), .i_rst(i_rst), .o_num(random_N));
	wire target_N = hit_occurred ? hit_N : empty_found ? empty_N : {random_N[size_N-1:1], use_mem [set_adrs]}; // final N #note0001

	// internal state
	reg [$clog2(4)-1:0] state;
	localparam 
		idle_st 			  = 0, 
		lookup_st 		  = 1, 
		evacuate_st 	  = 2, 
		write_st 		  = 3, 
		read_hit_st      = 4, 
		read_miss_st     = 5, 
		await_higher_st  = 6, 
		write_missing_st = 7;
 // todo: update states
 
	always @(*) begin
		if(i_rst) begin 
			state = 0;
			hit_N = 0;
			i = 0;
			empty_found = 0;
			hit_occurred = 0;
		end
		else begin
			case (state)

				idle_st: begin
					if (i_state_lower == queue_read_missing_st || 
					  	 i_state_lower == queue_read_evac_st	 ||
						 i_state_lower == write_order_st			 ||
						 i_state_lower == queue_write_evac_st) 
						 	state = lookup_st;
				end

				lookup_st: begin
					hit_check();

					case(i_state_lower)
						queue_read_missing_st, queue_read_evac_st: state = read_st;
						write_order_st, queue_write_evac_st: 		 state = write_st;
					endcase
				end

				read_st: begin
					if 	  (hit_occurred) state = read_exec_st;
					else if (empty_found)  state = queue_read_missing_st;
					else 						  state = queue_read_evac_st;
				end
				read_exec_st: begin
					// handlede elsewhere
					// leads to read_done_st state
				end
				queue_read_evac_st: begin
					if (phase_done && is_lowest_not_done) state = read_evac_st;
					else transparent = 1'b1;
				end
				read_evac_st: begin
					// todo: evacuation
					state = i_mem_write ? write_st : read_st; // todo: add state declarations
				end
				queue_read_missing_st: begin
					if (phase_done && is_lowest_not_done) state = read_missing_st;
					else transparent = 1'b1;
				end
				read_missing_st: begin

				end
				transparent_st: begin
					transparent = 1'b1;
				end
				read_evac_st: begin
					// todo: init read request to higher level
					o_mem_write_higher = 1;
					o_mem_operation_higher = 1;

					if (i_mem_operation_higher_done) state = read_missing_st;
				end

				// read_st: begin
				// elsewhere
				// end

				await_higher_hit_st: begin
					if (i_mem_operation_higher_done)
						state = write_missing_st;
				end

			endcase
		end
	end

	// tasks
	task hit_check ();
		begin
			#200;
			for (i=0; i<N; i=i+1) begin
				if (valid_mem[i][set_adrs]) begin
					if (tag_adrs == tag_mem[i][set_adrs]) begin
						hit_occurred = 1'b1;
						hit_N = i;
					end
				end else begin
					empty_found = 1'b1;
					empty_N = i;
				end
			end
		end
	endtask

	// actual read/write operations
	always @(posedge i_clk) begin : read_write
		integer i0;
		integer i1;
		integer i2;
		integer i3;
		if (i_rst) begin

			o_mem_write_higher     <= 0;
			o_address_higher 	  	  <= 0;
			o_mem_operation_higher <= 0;

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

				state <= idle_st;
			end

			if (state == write_missing_st) begin
				#20000
				data_mem  [target_N][set_adrs][block_offset_adrs][byte_offset_adrs] <= i_write_data; 
				valid_mem [target_N][set_adrs] <= 1;
				dirty_mem [target_N][set_adrs] <= 1;
				use_mem	   		  [set_adrs] <= !use_mem [set_adrs]; // inverted on write

				state <= idle_st;
			end

			////////////////////////////////////// read
			if (state == read_st) begin
				#20000
				o_read_data <= data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];
				state <= idle_st;
			end

		end
	end
endmodule



module virtual_memory
#(
	parameter size = 32 // number of words
)
(
	input         		i_clk, 
	input      			i_rst,

	input      		 	i_mem_write,
	input		  [31:0]	i_address,

	input  	  [7:0] 	i_write_data,
	output reg [7:0] 	o_read_data,

	input 				i_mem_operation,
	output 				o_mem_operation_done
);
	reg [7:0] mem [size:0] [3:0]; // 4 bytes in each word
	integer i;
	// state machine vars
	localparam idle_st = 0, read_st = 1, write_st = 2, valid_st = 3;
	reg [$clog2(3)-1:0] state;

	assign o_mem_operation_done = state == valid_st;

	always @(posedge i_clk) begin
		if (i_rst) begin
			i <= 0;
			state <= 0;
			o_read_data <= 0;
			for (i=0; i<=size; i=i+1) begin
				{mem[i][3], mem[i][2], mem[i][1], mem[i][0]} <= 0;
			end
		end else begin
			case(state)
				idle_st: begin
					if (i_mem_operation) begin
						state <= i_mem_write ? write_st : read_st;
					end
				end
				read_st: begin
					o_read_data <= #20000 mem[i_address[31:2]][i_address[1:0]];
					#20000;
					state <= valid_st;
				end
				write_st: begin
					mem[i_address[31:2]][i_address[1:0]] <= #20000 i_write_data;
					#20000;
					state <= valid_st;
				end
				valid_st: begin
					if (!i_mem_operation) begin
						state <= idle_st;
					end
				end
			endcase
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
