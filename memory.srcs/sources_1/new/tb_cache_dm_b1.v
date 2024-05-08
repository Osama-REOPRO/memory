// directly mapped, block size 1

`timescale 1us / 1ns

module tb_cache_dm_b1;
reg  			clk, rst;
reg  			mem_write;
reg 			diry_replace;
reg  [31:0] address;
reg  [7:0]  write_data;
wire [7:0]  read_data;
reg  			mem_operation;
wire 			mem_operation_done;
wire 			success;
reg 			word_op;

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{clk, mem_operation, mem_write, address, write_data, word_op} = 0;
	rst = 1;
	#0.2
	rst = 0;
end

integer valToWrite;
integer adrsToWrite;
integer state;
localparam idle_st 		  = 0, 
			  read_init_st   = 1, 
			  await_read_st  = 2, 
			  write_init_st  = 3, 
			  await_write_st = 4;

always @(posedge clk) begin
	if(rst) begin
		mem_operation  <= 0;
		mem_write 		<= 0;
		diry_replace   <= 0;
		address        <= 0;
		write_data 		<= 0;
		valToWrite 		<= 0;
		adrsToWrite 	<= 0;
		state 			<= 0;
	end else begin
		case (state)
			idle_st: begin
				if (!mem_operation_done) state = mem_write ? read_init_st : write_init_st;
				// reverse the operation each time
			end
			write_init_st: begin
				mem_operation <= 1;
				mem_write 	  <= 1;
				write_data 	  <= valToWrite;
				state 		  <= await_write_st;
			end
			await_write_st: begin
				if (mem_operation_done) begin
					mem_operation <= 0;
					state 		  <= idle_st;
					if (success) begin
						diry_replace  <= 0;
					end else begin
						diry_replace  <= 1;
						mem_write	  <= 0; // so write operation repeat
					end
				end
			end
			read_init_st: begin
				mem_operation <= 1;
				mem_write 	  <= 0;
				state 		  <= await_read_st;
			end
			await_read_st: begin
				if (mem_operation_done) begin
					mem_operation <= 0;
					state 		  <= idle_st;
					if (success) begin
						valToWrite <= read_data + 1;
						address 	  <= address + 1;
					end else begin
						mem_write	  <= 1; // repeat read on fail, (loops forever)
					end
				end
			end
		endcase
	end
end

cache 
#(
	.I_C(8), // capacity (words)
	.I_b(2), // block size (words in block)
	.I_N(1)  // degree of associativity
) 
cache 
(
	.i_clk(clk),
	.i_rst(rst),

	.i_mem_write(mem_write),
	.i_dirty_replace(diry_replace),
	.i_address(address),

	.i_write_data(write_data),
	.i_word_op(word_op),
	.o_read_data(read_data),

	.i_mem_operation(mem_operation),
	.o_mem_operation_done(mem_operation_done),
	.o_success(success)
);

endmodule
