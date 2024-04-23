`timescale 1us / 1ns

`define MEM_INVALID_STATE 0
`define MEM_BUSY_STATE   1
`define MEM_VALID_STATE  2
`define MEM_READY_STATE  3


`define memory_system_state_reg_len 3
`define cache_state_reg_len 3


`define ready_st_mem_sys 0
`define busy_st_mem_sys 1
`define valid_st_mem_sys 2
`define prep_st_mem_sys 3


`define valid_st_cache 0
`define miss_st_cache 1
`define hit_st_cache 2

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
		input         i_mem_operation,
		output        o_mem_operation_done,
		input  		  i_mem_write,
		input	 [31:0] i_address,
		input  [7:0]  i_write_data,
		output [7:0]  o_read_data
	);

	reg [`memory_system_state_reg_len-1:0] state;
	always @(*) begin
		case (state)
			`ready_st_mem_sys: begin
				if (i_mem_operation) begin
					state = `busy_st_mem_sys;
				end
			end
			`busy_st_mem_sys: begin
				if (cache_valid) begin /* todo */
					state = `valid_st_mem_sys;
				end
			end
			`valid_st_mem_sys: begin
				if (all_caches_valid) begin /* todo */
					state = `ready_st_mem_sys;
				end else if (!i_mem_operation) begin
					state = `prep_st_mem_sys;
				end
			end
			`prep_st_mem_sys: begin
				if (all_caches_valid) begin
					state = `ready_st_mem_sys;
				end
			end
		endcase
	end

	assign o_mem_operation_done = state == `valid_st_mem_sys ? 1 : 0;

	// cache instantiations
	// wire [7:0] cache_read_data_1, cache_read_data_2, cache_read_data_physical, virtual_memory_read_data;

	// assign o_read_data = /* cache_hit_1? cache_read_data_1 : cache_hit_2? cache_read_data_2 : cache_hit_physical? cache_read_data_physical : */ virtual_memory_read_data;

	wire hit_occurred = cache_valid_1 || cache_valid_2 || cache_valid_physical;


	cache #(.C(8), .b(1), .N(1)) 
	cache_direct_mapped_l_1 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_mem_system_state(
		.i_mem_operation(mem_operation),
		.i_mem_write(mem_write), // later
		.i_address(i_address),
		.o_cache_hit(cache_hit_1),
		.i_write_data(write_data),
		.o_read_data(cache_read_data_1)
	);

	//   cache cache_level_1 (
	//		.i_clk(clk),
	//		.i_rst(rst),
	//		.i_mem_operation(mem_operation),
	//		.i_mem_write(mem_write), // later
	//		.i_address(i_address),
	//		.o_cache_hit(cache_hit_1),
	//		.i_write_data(write_data),
	//		.o_read_data(cache_read_data_1)
	//		);

	//	cache cache_level_2 (
	//		.i_clk(clk),
	//		.i_rst(rst),
	//		.i_mem_operation(mem_operation && !cache_hit_1),
	//		.i_mem_write(mem_write), // later
	//		.i_address(i_address),
	//		.o_cache_hit(cache_hit_2),
	//		.i_write_data(write_data),
	//		.o_read_data(cache_read_data_2)
	//		);

	//	cache cache_physical_memory (
	//		.i_clk(clk),
	//		.i_rst(rst),
	//		.i_mem_operation(mem_operation && !cache_hit_1 && !cache_hit_2),
	//		.i_mem_write(mem_write), // later
	//		.i_address(i_address),
	//		.o_cache_hit(cache_hit_2),
	//		.i_write_data(write_data),
	//		.o_read_data(cache_read_data_physical)
	//		);

	// virtual_memory v_mem(
		// .i_clk(i_clk),
		// .i_rst(i_rst),
		// .i_mem_operation(i_mem_operation /* && !cache_hit_1 && !cache_hit_2 && !cache_hit_physical*/),
		// .o_mem_operation_done(o_mem_operation_done),
		// .i_mem_write(i_mem_write), // later
		// .i_address(i_address),
		// .i_write_data(i_write_data),
		// .o_read_data(virtual_memory_read_data)
	// );
	endmodule

	module cache
	#(
		parameter C = 8,   // capacity (words)
		parameter b = 2,   // block size
		parameter N = 2    // degree of associativity
	)
	(
		input       											  		i_clk, 
		input         													i_rst,
		input 	  [`memory_system_state_reg_len-1:0]		i_mem_system_state,
		input 	  [`cache_state_reg_len-1:0]					i_lower_cache_state,
		output reg [`cache_state_reg_len-1:0]					o_state,
		input 											     		   i_mem_write,
		input		  [31:0]												i_address,
		input  	  [7:0] 												i_write_data,
		output reg [7:0]												o_read_data
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

	// internal state
	localparam valid_st = 0, lookup_st = 1, hit_st = 2, miss_st = 3, load_missing_st = 4;
	reg [$clog2(5)-1:0] state;
	always @(*) begin
		if(i_rst) state = valid_st;
		else begin
			case (state) begin
				valid_st: begin
					if(i_mem_system_state==`busy_st_mem_sys && i_lower_cache_state == `miss_st_cache) begin
						state = lookup_st;
					end
				end
				// lookup_st: begin
					// handlede elsewhere
				// end
				// hit_st: begin
					// handlede elsewhere
				// end
				miss_st: begin
					if (i_mem_system_state == `valid_st_mem_sys) begin
						state = load_missing_st;
					end
				end
			endcase
		end
	end

	// external state
	always @(*) begin
		if(i_rst) o_state = `valid_st_cache;
		else begin
			case (o_state) begin
				`valid_st_cache: begin
					if				(state == hit_st)		o_state = `hit_st_cache;
					end else if (state == miss_st)	o_state = `miss_st_cache;
					end else									o_state = `valid_st_cache;
				end
				`hit_st_cache: begin
					if (state == valid_st) begin
						o_state = `valid_st_cache;
					end
				end
				`miss_st_cache: begin
					if (state == valid_st) begin
						o_state = `valid_st_cache;
					end
				end
			endcase
		end
	end

	// hit test
	integer i;
	reg [$clog2(N)-1:0] hit_N; // which of the N-ways the hit occurred in
	always @(*) begin
		if (i_rst) begin 
			hit_N = 0;
		end else if (state == lookup_st) begin
			#200;
			// state = miss_st; // todo: does this work? I remember this was problematic
			for (i=0; i<N; i=i+1) begin
				if((valid_mem[i][set_adrs])&&(tag_adrs == tag_mem[i][set_adrs]))begin
					hit_N = i;
					// state = hit_st;
				end
			end
			state = |hit_N ? hit_st : miss_st;
		end
	end

	// actual read/write operations
	integer i0, i1, i2, i3;
	always @(posedge i_clk) begin
		if (i_rst) begin
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
			if (state == hit_st || state == load_missing_st) begin // todo: then why the two states?
				if (i_mem_write) begin
					// write operation (todo)
					// todo: this is completely outdated, it comes from virtual memory, it was copied from there
					#20000
					data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs] <= i_write_data; 
					state <= valid_st;
				end else begin
					// read operation
					#20000
					o_read_data <= data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];
					state <= valid_st;
				end
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
	input         		i_rst,
	input         		i_mem_operation,
	output reg			o_mem_operation_done,
	input      		   i_mem_write,
	input		  [31:0] i_address,
	input  	  [7:0]  i_write_data,
	output reg [7:0]  o_read_data
);
reg [7:0] mem [size:0] [3:0]; // 4 bytes in each word
integer i;
// state machine vars
localparam idle_st = 0, read_st = 1, write_st = 2, done_st = 3;
reg [$clog2(done_st)-1:0] state;

always @(posedge i_clk) begin
	if (i_rst) begin
		i <= 0;
		state <= 0;
		o_read_data <= 0;
		o_mem_operation_done <= 1;
		for (i=0; i<=size; i=i+1) begin
			{mem[i][3], mem[i][2], mem[i][1], mem[i][0]} <= 0;
		end
	end else begin
		case(state)
			idle_st: begin
				if (i_mem_operation) begin
					o_mem_operation_done <= 0;
					state <= i_mem_write ? write_st : read_st;
				end
			end
			read_st: begin
				o_read_data <= #20000 mem[i_address[31:2]][i_address[1:0]];
				#20000;
				state <= done_st;
			end
			write_st: begin
				mem[i_address[31:2]][i_address[1:0]] <= #20000 i_write_data;
				#20000;
				state <= done_st;
			end
			done_st: begin
				o_mem_operation_done <= 1;
				state <= idle_st;
			end
		endcase
	end
end
endmodule
