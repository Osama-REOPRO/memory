`timescale 1ns / 1ps

module tb;
	reg clk, rst;
	reg mem_operation;
	reg mem_write;
	reg [31:0] address;
	reg [31:0] write_data;
	wire [31:0] read_data;
	
	always #1 clk <= !clk;
	
	virtual_memory vmem (
		.i_clk(clk),
		.i_rst(rst),
		.i_mem_operation(mem_operation),
		.i_mem_write(mem_write),
		.i_address(address),
		.i_write_data(write_data),
		.o_read_data(read_data)
		);
	initial begin
		{clk, mem_operation, mem_write, address, write_data} = 0;
		rst = 1;
		#2
		rst = 0;
	end
endmodule

module virtual_memory(
	input         		i_clk, 
   input         		i_rst,
   input         		i_mem_operation,
   input      		   i_mem_write,
   input		  [31:0] i_address,
   input  	  [31:0] i_write_data,
   output reg [31:0] o_read_data
    );
   reg [31:0] mem [31:0];
   integer i;
	always @(posedge i_clk) begin
		if (i_rst) begin
			i <= 0;
			o_read_data <= 0;
			for (i=0; i<32; i=i+1) begin
				mem[i] <= 0;
			end
		end else begin
			if (i_mem_operation) begin
				if (i_mem_write) begin
					// write operation
					mem[i_address] <= i_write_data;
		 		end else begin
					// read operation
					o_read_data <= mem[i_address];
		 		end
			end
		end
	end
endmodule
