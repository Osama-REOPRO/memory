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

input [$clog2(4*b)-1:0] n_bytes;

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
		
		n_bytes,
		                  
		write_data,
		read_data,
		                  
		mem_operation_done } = 0


	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite;
reg 		 phase; // 0 is write, 1 is read (so write is first)

integer state;
localparam idle_st 		  = 0, 
			  lookup_st 	  = 1,
			  read_init_st   = 2, 
			  await_read_st  = 3, 
			  write_init_st  = 4, 
			  await_write_st = 5;

always @(posedge clk) begin
	if(rst) begin
		mem_operation  <= 1'b0;
		address        <= 1'b0;
		write_data 		<= 1'b0;
		valToWrite 		<= 1'b0;
		state 			<= 1'b0;
		phase 			<= 1'b0;
	end else begin
		case (state)
			idle_st: begin
				address <= address + 1;
				state   <= write_lookup_st;
			end

			///////////// write
			write_lookup_st: begin
				case (sub_state)
					init: begin
						op 			  <= `lookup_op;
						mem_operation <= 1'b1;
						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done) 
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							if 	  (hit_occurred) 					  state <= write_st;				  // write right away
							else if (empty_found || clean_found)  state <= write_fill_empty_st; // fill with zeroes then write
							else 											  state <= write_evac_read_st;

							sub_state <= init;
						end
					end
				endcase
			end

			write_st: begin
				case (sub_state)
					init: begin
						write_data [7:0] <= valToWrite;
						op 			     <= `write_op;
						mem_operation    <= 1'b1;
						sub_state	     <= busy;
						set_dirty		  <= 1'b1;
						set_use			  <= 1'b1;
						n_bytes			  <= 1;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							state		 <= read_lookup_st;
							sub_state <= init;
						end
				endcase

				// todo
				write_fill_empty_st: begin
					case (sub_state)
						init: begin
							write_data <= {(32*b){1'b0}};
							op 			     <= `write_op;
							mem_operation    <= 1'b1;
							n_bytes			  <= 4*b;
							sub_state	     <= busy;
						end
						busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
						finish: begin
						end
					endcase
				end

				// todo
				write_evac_read_st: begin
					case (sub_state)
						init: begin
						end
						busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
						finish: begin
						end
					endcase
				end


				// if (mem_operation_done) 
				// mem_operation <= 1;
				// mem_write 	  <= 1;
				// if  (word_missing) write_data 	   <= 32'b0; // fill with zeros
				// else 					 write_data [7:0] <= valToWrite;
				// state 		  <= await_write_st;
				// word_op 		  <= word_missing || dirty_replace;
// 
				// if (mem_operation_done) begin
					// mem_operation 	  <= 0;
					// state 		  	  <= idle_st;
					// if (success) begin
						// dirty_replace  <= 1'b0;
						// word_op 		  <= 1'b0;
						// if (word_op) mem_write <= 1'b0; // repeat if previous word refill
					// end else begin
						// if (!word_missing) begin
							// dirty_replace  <= 1;
							// word_op 		  <= 1;
						// end
						// mem_write	  <= 0; // so write operation repeat
					// end
				// end
			// end




			read_lookup_st: begin
				case (sub_state)
					init: begin
						op 			  <= `lookup_op;
						mem_operation <= 1'b1;
						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done) 
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							if 	  (hit_occurred) 					  state <= read_st;				  // read right away
							else if (empty_found || clean_found)  state <= read_fill_empty_st; // fill with zeroes then write
							else 											  state <= read_evac_st;

							sub_state <= init;
						end
					end
				endcase
			end

			read_st: begin
				case (sub_state)
					init: begin
						op 			     <= `read_op;
						mem_operation    <= 1'b1;
						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							valToWrite <= read_data[7:0] + 1;
							address 	  <= address + 1;
							state		  <= write_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end


			// todo
			read_fill_empty_st: begin
				case (sub_state)
					init: begin
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
					end
					finish: begin
					end
				endcase
			end

			// todo
			read_evac_st: begin
				case (sub_state)
					init: begin
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b1;
							sub_state 	  <= finish;
						end
					end
					finish: begin
					end
				endcase
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
