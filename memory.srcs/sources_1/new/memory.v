`timescale 1us / 1ns

`define MEM_UNINIT_STATE 0
`define MEM_BUSY_STATE   1
`define MEM_VALID_STATE  2
`define MEM_READY_STATE  3

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
    
   wire 		 	cache_hit_1, 		 cache_hit_2, 		  cache_hit_physical;
   wire [31:0] cache_read_data_1, cache_read_data_2, cache_read_data_physical, virtual_memory_read_data;
    
   assign o_read_data = /* cache_hit_1? cache_read_data_1 : cache_hit_2? cache_read_data_2 : cache_hit_physical? cache_read_data_physical : */ virtual_memory_read_data;
   wire hit_occurred = cache_hit_1 || cache_hit_2 || cache_hit_physical;


	cache #(.C(8), .b(1), .N(1)) 
		cache_direct_mapped_l_1 (
		.i_clk(clk),
		.i_rst(rst),
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
	
	virtual_memory v_mem(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_mem_operation(i_mem_operation /* && !cache_hit_1 && !cache_hit_2 && !cache_hit_physical*/),
		.o_mem_operation_done(o_mem_operation_done),
		.i_mem_write(i_mem_write), // later
		.i_address(i_address),
		.i_write_data(i_write_data),
		.o_read_data(virtual_memory_read_data)
		);
endmodule

module cache
	#(
		parameter C = 8,   // capacity (words)
		parameter b = 2,   // block size
		parameter N = 2    // degree of associativity
	)
	(
		input         		i_clk, 
		input         		i_rst,
		input         		i_mem_operation,
		output reg [1:0]	o_state,
		input      		   i_mem_write,
		input		  [31:0] i_address,
		output reg			o_cache_hit,
		input					i_another_cache_hit,
		input  	  [7:0]  i_write_data,
		output reg [7:0]  o_read_data
    );

	// registers that store inputs while they are in use
	reg 		  mem_write;
	reg [31:0] address;
	reg [7:0]  write_data;

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

	// reg [Use_bit + ((2+Tag_nbytes+(32*b)) * N) - 1:0] cache_mem [S-1:0]; 
	// maybe there is no need to combine them into a single thing
	
	// todo: check if should do -1
	wire [Byte_offset_nbytes-1:0]  byte_offset_adrs  =	i_address[						 0 +:	Byte_offset_nbytes-1		]; 
	wire [Block_offset_nbytes-1:0] block_offset_adrs = i_address[Byte_offset_nbytes	+:	Block_offset_nbytes-1	];
	wire [Set_nbytes-1:0] 			 set_adrs 			 =	i_address[Block_offset_nbytes	+:	Set_nbytes-1				];
	wire [Tag_nbytes-1:0] 			 tag_adrs 			 =	i_address[Set_nbytes				+:	Tag_nbytes-1				];
	
	integer i;
	// todo: test hit
	reg [$clog2(N)-1:0] hit_N;
	localparam lookup_idle = 0, lookup_busy = 1, lookup_hit = 2, lookup_miss = 3;
	reg [1:0] lookup_state;
	always @(*) begin
		if (i_rst) begin 
			hit_N = 0;
			lookup_state = lookup_idle;
		end else if (i_mem_operation) begin
			lookup_state = lookup_busy;
			#200;
			for (i=0; i<N; i=i+1) begin
				if((valid_mem[i][set_adrs])&&(tag_adrs == tag_mem[i][set_adrs]))begin
					hit_N = i;
					o_cache_hit = 1;
					lookup_state = lookup_busy;
				end
			end
		end
	end

	// state machine vars
	localparam idle_st = 0, read_st = 1, write_st = 2, done_st = 3;
	reg [$clog2(done_st)-1:0] state;

	integer i0, i1, i2, i3;
	always @(posedge i_clk) begin
		if (i_rst) begin
			o_state <= 0;
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
			case(state)
				uninit_st: begin
					o_state <= `MEM_UNINIT_STATE;
					if (i_mem_operation) begin
						// store data for whole operation
						mem_write <= i_mem_write;
						address <= i_address;
						if (i_mem_write) write_data <= i_write_data;

						state <= i_mem_write ? busy_write_st : busy_read_st;
					end
				end
				busy_read_st: begin
					o_state <= `MEM_BUSY_STATE;
					if (o_cache_hit) begin
						o_read_data <= #200 data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];
						#200;
					end else if (i_another_cache_hit) begin
						
					end
				end
				busy_write_st: begin
					o_state <= `MEM_BUSY_STATE;
					if (o_cache_hit) begin
						o_read_data <= #200 data_mem[hit_N][set_adrs][block_offset_adrs][byte_offset_adrs];
						#200;
						state <= done_st;
					end
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
