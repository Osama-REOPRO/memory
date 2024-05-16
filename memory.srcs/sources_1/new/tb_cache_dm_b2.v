// directly mapped, block size 2

`timescale 1us / 1ns
`include "cache_ops.vh"

module tb_cache_dm_b2;
reg  			clk, rst;
reg  			mem_write;
reg 			word_op;
reg 			set_dirty;
reg  [31:0] address;
reg  [31:0] write_data;
wire [31:0] read_data;
reg  			mem_operation;
wire 			mem_operation_done;
wire 			success;
wire 			word_missing;

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{clk, mem_operation, mem_write, address, write_data, word_op} = 0;
	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite;
integer 	 adrsToWrite;

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
		set_dirty  <= 0;
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
				if  (word_missing) write_data 	   <= 32'b0; // fill with zeros
				else 					 write_data [7:0] <= valToWrite;
				state 		  <= await_write_st;
				word_op 		  <= word_missing || set_dirty;
			end
			await_write_st: begin
				if (mem_operation_done) begin
					mem_operation 	  <= 0;
					state 		  	  <= idle_st;
					if (success) begin
						set_dirty  <= 1'b0;
						word_op 		  <= 1'b0;
						if (word_op) mem_write <= 1'b0; // repeat if previous word refill
					end else begin
						if (!word_missing) begin
							set_dirty  <= 1;
							word_op 		  <= 1;
						end
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
						valToWrite <= read_data[7:0] + 1;
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
	.C(8), // capacity (words)
	.b(2), // block size (words in block)
	.N(1)  // degree of associativity
) 
cache 
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op),
	.i_address(address),

	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

	.i_mem_operation(mem_operation),

	.o_hit_occurred(hit_occurred),
	.o_empty_found(empty_found),
	.o_clean_found(clean_found),

	.i_n_bytes(n_bytes),

	.i_write_data(write_data),
	.o_read_data(read_data),

	.o_mem_operation_done(mem_operation_done)
);

endmodule
