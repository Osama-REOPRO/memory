// directly mapped, block size 1

`timescale 1us / 1ns
`include "cache_ops.vh"

module tb_cache_dm_b1;


localparam C = 8;   // capacity (total words)
localparam b = 1;   // block size (words per block)
localparam N = 1;   // degree of associativity (blocks per set)

reg  			  clk, rst;

reg [`op_N:0] op;

reg  [31:0]   address;

reg 			  set_valid;
reg			  set_tag;
reg 			  set_dirty;
reg 			  set_use;

reg  			  mem_operation;

wire 			  hit_occurred;
wire 			  empty_found;
wire 			  clean_found;

reg [(4*b)-1:0] 	valid_bytes;

reg  [(32*b)-1:0]	write_data;
wire [(32*b)-1:0]	read_data;

wire 							mem_operation_done;

always #0.1 clk <= !clk; // clock runs at 10 MHz

initial begin
	{	clk, rst,
	             
		op,
		             
		address,
		             
		set_dirty,
		set_use,
		             
		mem_operation,
		             		
		valid_bytes,
		                  
		write_data } = 0;


	rst = 1;
	#0.2
	rst = 0;
end

reg [7:0] valToWrite;

integer state;
localparam write_lookup_st 	 	= 0,
			  write_st 		  		 	= 1,
			  write_fill_empty_w_st = 2,
			  write_evac_r_st  		= 3,
			  read_lookup_st		 	= 4,
			  read_st 		  		 	= 5,
			  read_fill_empty_w_st	= 6,
			  read_evac_r_st			= 7;
		  
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;
always @(posedge clk) begin
	if(rst) begin
		mem_operation  <= 1'b0;
		address        <= 1'b0;
		write_data 		<= 1'b0;
		valToWrite 		<= 1'b0;
		state 			<= 0;
		sub_state		<= 0;
		
		set_valid		<= 1'b0;
		set_tag			<= 1'b0;
		set_dirty		<= 1'b0;
		set_use			<= 1'b0;

	end else begin
		case (state)
			///////////// write
			write_lookup_st: begin

				case (sub_state)
					init: begin
						op 			  <= `lookup_op;
						mem_operation <= 1'b1;
						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							if 	  (hit_occurred) 					  state <= write_st;					 // write right away
							else if (empty_found || clean_found)  state <= write_fill_empty_w_st; // fill with zeroes then write
							else 											  state <= write_evac_r_st;

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
						valid_bytes			  <= address;

						set_dirty		  <= 1'b1;
						set_use			  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							state		 <= read_lookup_st;
							sub_state <= init;
						end
					end
				endcase
			end

			write_fill_empty_w_st: begin
				case (sub_state)
					init: begin
						write_data <= {(32*b){1'b0}};
						op 			     <= `write_op;
						mem_operation    <= 1'b1;
						valid_bytes			  <= {4*b{1'b1}}; // all valid
						set_valid		  <= 1'b1;
						set_tag			  <= 1'b1;

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							state		 <= write_st;
							sub_state <= init;
						end
					end
				endcase
			end

				// we read the data but do nothing with it
				write_evac_r_st: begin
					case (sub_state)
						init: begin
							op 			  <= `read_op;
							mem_operation <= 1'b1;
							valid_bytes	  <= {4*b{1'b1}};
							sub_state	  <= busy;
						end
						busy: begin
							if (mem_operation_done) begin
								mem_operation <= 1'b0;
								sub_state 	  <= finish;
							end
						end
						finish: begin
							if (!mem_operation_done) begin
								state		  <= write_fill_empty_w_st;
								sub_state  <= init;
							end
						end
					endcase
				end


			read_lookup_st: begin
				case (sub_state)
					init: begin
						op 			  <= `lookup_op;
						mem_operation <= 1'b1;
						sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							if 	  (hit_occurred) 					  state <= read_st;				  // read right away
							else if (empty_found || clean_found)  state <= read_fill_empty_w_st; // fill with zeroes then write missing
							else 											  state <= read_evac_r_st;

							sub_state <= init;
						end
					end
				endcase
			end

			read_st: begin
				case (sub_state)
					init: begin
						op 			     		<= `read_op;
						mem_operation    		<= 1'b1;
						valid_bytes <= {(4*b){1'b0}};
						valid_bytes[address] <= 1'b1;
						sub_state	     		<= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							$strobe("=======================> increment data: valToWrite <= read_data[%0d -: 8] + 1 = %0d", address*8, valToWrite);
							valToWrite <= read_data[(address*8) -: 8] + 1;
							address 	  <= address + 1;
							state		  <= write_lookup_st;
							sub_state  <= init;
						end
					end
				endcase
			end


			// just fill with 0s
			read_fill_empty_w_st: begin
				case (sub_state)
					init: begin
						write_data <= {(32*b){1'b0}};
						op 			     <= `write_op;
						mem_operation    <= 1'b1;
						valid_bytes		  <= {4*b{1'b1}};

						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							state		 <= read_st;
							sub_state <= init;
						end
					end
				endcase
			end

			read_evac_r_st: begin
				case (sub_state)
					init: begin
						op 			     <= `read_op;
						mem_operation    <= 1'b1;
						valid_bytes		  <= {4*b{1'b1}};
						sub_state	     <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;
							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							state		  <= read_st;
							sub_state  <= init;
						end
					end
				endcase
			end


		endcase
	end
end




cache 
#(
	.C(C), // capacity (words)
	.b(b), // block size (words in block)
	.N(N)  // degree of associativity
) 
cache 
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op),

	.i_address(address),

	.i_set_valid(set_valid),
	.i_set_tag(set_tag),
	.i_set_dirty(set_dirty),
	.i_set_use(set_use),

	.i_mem_operation(mem_operation),

	.o_hit_occurred(hit_occurred),
	.o_empty_found(empty_found),
	.o_clean_found(clean_found),

	.i_valid_bytes(valid_bytes),

	.i_write_data(write_data),
	.o_read_data(read_data),

	.o_mem_operation_done(mem_operation_done)
);

// logs
initial $display("\n\n(%0t) logs start //////////////////////////////////////////\n\n", $time);
always @(state) begin
	$write("(%0t) ", $time);
	$write("---------------------------------------------------> testbench state: ");
	case (state)
		write_lookup_st: 			$write("write_lookup_st\n");
	   write_st: 					$write("write_st\n");
		write_fill_empty_w_st: 	$write("write_fill_empty_w_st\n");
		write_evac_r_st: 			$write("write_evac_r_st\n");
		read_lookup_st: 			$write("read_lookup_st\n");
		read_st: 					$write("read_st\n");
		read_fill_empty_w_st: 	$write("read_fill_empty_w_st\n");
		read_evac_r_st: 			$write("read_evac_r_st\n");
	endcase
end

always @(sub_state) begin
	$write("(%0t) ", $time);
	$write("--------------------------> sub-state: ");
	case (sub_state)
		init: 	$write("init\n");
		busy: 	$write("busy\n");
		finish: 	$write("finish\n-----------------------------------------------------------------------------****\n\n");
	endcase
end

always @(hit_occurred) $write("(%0t) ######### hit_occurred = %b\n", $time, hit_occurred);
always @(empty_found)  $write("(%0t) ######### empty_found = %b\n", $time, empty_found);
always @(clean_found)  $write("(%0t) ######### clean_found = %b\n", $time, clean_found);

always @(cache.data_mem) begin
	$display(cache.data_mem);
end
wire [7:0] previous_read_data = read_data[address-1 +: 8];

endmodule
