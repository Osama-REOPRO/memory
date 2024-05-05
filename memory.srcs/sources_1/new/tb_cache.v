`timescale 1us / 1ns

module tb_cache;
reg  			clk, rst;
reg  			mem_write;
reg  [31:0] address;
reg  [7:0]  write_data;
wire [7:0]  read_data;
reg  			mem_operation;
wire 			mem_operation_done;
wire 			success;

always #0.1 clk <= !clk; // clock runs at 10 MHz

cache 
#(
	.C(8), // capacity (words)
	.b(1), // block size (words in block)
	.N(1)  // degree of associativity
) 
cache 
(
	.i_clk(clk),
	.i_rst(rst),

	.i_mem_write(mem_write),
	.i_address(address),

	.i_write_data(write_data),
	.o_read_data(read_data),

	.i_mem_operation(mem_operation),
	.o_mem_operation_done(mem_operation_done),
	.o_success(success)
);


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
				#200;
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


initial begin
	{clk, mem_operation, mem_write, address, write_data} = 0;
	rst = 1;
	#1
	rst = 0;
end

endmodule
