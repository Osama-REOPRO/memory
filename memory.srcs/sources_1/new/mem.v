`timescale 1us / 1ns

module mem(
	input         i_clk, 
	input         i_rst,

	input  		  i_mem_write,
	input	 [31:0] i_address,
	input  [7:0]  i_write_data,

	input         i_mem_operation,

	output [7:0]  o_read_data,
	output        o_mem_operation_done
);
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
