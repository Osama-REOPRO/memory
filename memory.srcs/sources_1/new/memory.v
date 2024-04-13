`timescale 1us / 1ns

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
			valToWrite <= 1;
			adrsToWrite <= 1;
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
						valToWrite = read_data;
						state = read_init_st;
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
		parameter C = 8,   // capacity
		parameter b = 2,    // block size
		parameter N = 2  // degree of associativity
	)
	(
		input         		i_clk, 
		input         		i_rst,
		input         		i_mem_operation,
		input      		   i_mem_write,
		input		  [31:0] i_address,
		input					o_cache_hit,
		input  	  [7:0] i_write_data,
		output reg [7:0] o_read_data
    );

	localparam B = C/b;  // number of blocks
	localparam S = B/N;  // number of sets

	reg [7:0] cache_mem;
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
	always @(posedge i_clk) begin
		if (i_rst) begin
			i <= 0;
			o_read_data <= 0;
			o_mem_operation_done <= 1;
			for (i=0; i<=size; i=i+1) begin
				{mem[i][3], mem[i][2], mem[i][1], mem[i][0]} <= 0;
			end
		end else begin
			if (i_mem_operation && o_mem_operation_done) begin
				if (i_mem_write) begin
					// write operation
					o_mem_operation_done <= 0;
					#20000;
					mem[i_address[31:2]][i_address[1:0]] <= i_write_data;
					o_mem_operation_done 					 <= 1;
		 		end else begin
					// read operation
					o_mem_operation_done <= 0;
					#20000;
					o_read_data 			<= mem[i_address[31:2]][i_address[1:0]];
					o_mem_operation_done <= 1;
		 		end
			end
		end
	end
endmodule
