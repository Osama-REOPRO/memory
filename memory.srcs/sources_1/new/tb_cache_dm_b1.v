// directly mapped, block size 1

`timescale 1us / 1ns
`include "cache_ops.vh"

module tb_cache_dm_b1;


localparam C = 8,   // capacity (total words)
localparam b = 2,   // block size (words per block)
localparam N = 1    // degree of associativity (blocks per set)

reg  			  clk, rst;

reg [`op_N:0] op;

reg  [31:0]   address;

reg 			  set_dirty;
reg 			  set_use;

reg  			  mem_operation;

reg 			  hit_occurred
reg 			  empty_found,
reg 			  clean_found,

input [$clog2(4*b)-1:0] i_n_bytes;

reg  [(32*b)-1:0] 		write_data;
wire [(32*b)-1:0] 		read_data;

wire 							mem_operation_done;

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{	clk, rst,
	             
		op,
		             
		address,
		             
		set_dirty,
		set_use,
		             
		mem_operation,
		             
		hit_occurred
		empty_found,
		clean_found,
		
		i_n_bytes,
		                  
		write_data,
		read_data,
		                  
		mem_operation_done } = 0


	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite;

integer state;
localparam idle_st 		  = 0, 
			  lookup_st 	  = 1,
			  read_init_st   = 2, 
			  await_read_st  = 3, 
			  write_init_st  = 4, 
			  await_write_st = 5;

always @(posedge clk) begin
	if(rst) begin
		mem_operation  <= 0;
		address        <= 0;
		write_data 		<= 0;
		valToWrite 		<= 0;
		state 			<= 0;
	end else begin
		case (state)
			idle_st: begin
				if (!mem_operation_done) begin 
					state = lookup_st;
					address 	  <= address + 1;
				end
			end

			lookup_st: begin
				op <= `lookup_op;
				mem_operation <= 1;
			end
			await_lookup_st: begin
				if (mem_operation_done) begin
			end

			write_init_st: begin
				mem_operation <= 1;
				mem_write 	  <= 1;
				if  (word_missing) write_data 	   <= 32'b0; // fill with zeros
				else 					 write_data [7:0] <= valToWrite;
				state 		  <= await_write_st;
				word_op 		  <= word_missing || dirty_replace;
			end
			await_write_st: begin
				if (mem_operation_done) begin
					mem_operation 	  <= 0;
					state 		  	  <= idle_st;
					if (success) begin
						dirty_replace  <= 1'b0;
						word_op 		  <= 1'b0;
						if (word_op) mem_write <= 1'b0; // repeat if previous word refill
					end else begin
						if (!word_missing) begin
							dirty_replace  <= 1;
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
	.I_C(8), // capacity (words)
	.I_b(1), // block size (words in block)
	.I_N(1)  // degree of associativity
) 
cache 
(
	.i_clk(clk),
	.i_rst(rst),

	.i_mem_write(mem_write),
	.i_word_op(word_op),
	.i_dirty_replace(dirty_replace),
	.i_address(address),

	.i_write_data(write_data),
	.o_read_data(read_data),

	.i_mem_operation(mem_operation),
	.o_mem_operation_done(mem_operation_done),
	.o_success(success),
	.o_word_missing(word_missing)
);

endmodule
