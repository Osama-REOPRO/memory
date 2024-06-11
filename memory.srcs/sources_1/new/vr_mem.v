`timescale 1us / 1ns
`include "access_sizes.vh"

module vr_mem
#(
	parameter c = 32, // capacity in bytes
	parameter b = 4,	// block size in words, used internally, always larger than external
	parameter b_lower = 2	// block size in words, used by lower level, always smaller
)
(
	input         					i_clk, 
	input      						i_rst,

	input      		 				i_mem_write,
	input      [$clog2(`N_access)-1:0] i_access_size, // power of 2 in bytes, 0 is 1-byte, 1 is 2-bytes (ignored), 2 is 4-bytes, etc. until block size
	input		  [31:0]				i_address,

	input  	  [(b*4*8)-1:0] 	i_write_data,
	output reg [(b*4*8)-1:0]	o_read_data,

	input 							i_mem_operation,
	output 							o_mem_operation_done
);
	localparam n_blocks = c/b;

	reg [7:0] mem [n_blocks-1:0][b-1:0][3:0];
	
	// todo: extract address portions
	// mem[adrs_block][adrs_block_lower][adrs_word][adrs_byte] <= #20000 i_write_data[7:0];
	localparam Byte_offset_nbytes  = 2; // offset of byte within word
	localparam Block_offset_nbytes = $clog2(b); // offset of word within block (more like word_offset)
	localparam Block_offset_nbytes = $clog2(b); // offset of word within block (more like word_offset)

	wire [1:0] 							adrs_byte = i_address[1:0];
	wire [Block_offset_nbytes:0] 	adrs_word = i_address[2+:$clog2(b)];
	wire adrs_block_lower = i_address[2+$clog2(b)]; // todo
	wire adrs_block = i_address[31:2+$clog2(b)]; // todo

	// state machine vars
	localparam idle_st = 0, read_st = 1, write_st = 2, valid_st = 3;
	reg [$clog2(3)-1:0] state;

	assign o_mem_operation_done = state == valid_st;

	always @(posedge i_clk) begin
		if (i_rst) begin
			integer i, j, k;
			state <= 0;
			o_read_data <= 0;
			for (i=0; i<=n_blocks; i=i+1) begin
				for (j=0; j<=b; j=j+1) begin
					for (k=0; k<=b; k=k+1) begin
						mem[i][j][k] <= 8'b0;
					end
				end
			end
		end else begin
			case(state)
				idle_st: begin
					if (i_mem_operation) begin
						state <= i_mem_write ? write_st : read_st;
					end
				end
				read_st: begin
					// 					todo
// 					case (i_access_size)
// 						`byte_access: begin
// 						end
// 						`word_access: begin
// 						end
// 						`block_access: begin
// 						end
// 						`block_lower_access: begin
// 						end
// 					endcase

					o_read_data <= #20000 mem[i_address[31:2]][i_address[1:0]];
					#20000;
					state <= valid_st;
				end
				write_st: begin
					case (i_access_size)
						`byte_access: begin
							mem[adrs_block][adrs_block_lower][adrs_word][adrs_byte] <= #20000 i_write_data[7:0];
						end
						`word_access: begin
							mem[adrs_block][adrs_block_lower][adrs_word] <= #20000 i_write_data[31:0];
						end
						`block_lower_access: begin
							mem[adrs_block][adrs_block_lower] <= #20000 i_write_data[b_lower*4*8-1:0];
						end
						`block_access: begin
							mem[adrs_block] <= #20000 i_write_data[b*4*8-1:0];
						end
					endcase

					#20000;
					state <= valid_st;
				end
				valid_st: begin
					if (!i_mem_operation) begin
						state <= idle_st;
					end
				end
			endcase
		end
	end
endmodule
