`timescale 1us / 1ns

module tb_fill_cache;

localparam C = 64;
localparam b = 2;
localparam N = 1;

reg clk, rst, mem_operation;
reg [2:0] op;
reg [31:0] address;
reg [(4*b)-1:0] valid_bytes;
reg [(32*b)-1:0] write_data;
wire [(32*b)-1:0] read_data;
wire mem_operation_done;

always #1 clk = ~clk;

initial begin
	clk = 0;
	rst = 0;
	#10
	rst = 1;
	#10
	rst = 0;
end

integer state;
localparam idle_st 				= 0,
			  write_test_vals_st = 1,
			  read_test_vals_st 	= 2;
			  
integer test_val = 0;
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;
			  
always @(posedge clk) begin
	if (rst) begin
		{mem_operation, op, address, valid_bytes, write_data, state, sub_state} <= 0;
	end else begin
		case (state)

			idle_st: begin
				state <= write_test_vals_st;
			end

			write_test_vals_st: begin
				case (sub_state)
					init: begin
						write_data [(((address % (4*b))+1)*8)-1 -: 8] <= test_val;
						// mul by 4 to get bytes per word, then by 8 to get bits per byte
						op 			     				  <= `write_op;
						mem_operation    		  				  <= 1'b1;
						valid_bytes 	  				  <= {(4*b){1'b0}};
						valid_bytes[address % (4*b)] <= 1'b1;

						sub_state	     				  <= busy;
					end
					busy: begin
						if (mem_operation_done) begin
							mem_operation <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done) begin
							sub_state <= init;
							if (test_val < 256) begin
								test_val <= test_val+1;
								address <= address+1;
							end else begin
								test_val <= 0;
								address <= 0;
								state <= read_test_vals_st;
							end
						end
					end
				endcase
			end
			
			read_test_vals_st: begin
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
test_mem
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op),

	.i_address(address),

	.i_set_valid(1'b1),
	.i_set_tag(1'b1),
	.i_set_dirty(1'b0),
	.i_set_use(1'b0),

	.i_mem_operation(mem_operation),

	.o_hit_occurred(),
	.o_empty_found(),
	.o_clean_found(),

	.i_valid_bytes(valid_bytes),

	.i_write_data(write_data),
	.o_read_data(read_data),

	.o_mem_operation_done(mem_operation_done)
);
endmodule
