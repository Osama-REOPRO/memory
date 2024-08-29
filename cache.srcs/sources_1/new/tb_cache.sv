`timescale 1ns / 1ps
`include "cache_ops.vh"

module tb_cache;

// cache parameters
parameter C  = 16; // capacity (total words)
parameter b  = 4; // block size (words per block)
parameter N  = 2; // degree of associativity (blocks per set)
localparam size_N = ($clog2(N)>0)? $clog2(N): 1;

reg clk = 0, rst;
always #1 clk = ~clk;

// cache signals
reg  [`op_N:0] 		op;
reg  [31:0] 			adrs;

reg 						set_valid;
reg 						set_tag;
reg 						set_dirty;
reg 						set_use;

reg 						use_manual_N;
reg  [size_N-1 : 0] 	manual_N;

reg 						mem_operation;

wire 						hit_occurred;
wire 						empty_found;
wire 						clean_found;
wire [31:0] 			adrs_target_N;
wire [size_N-1 : 0] 	target_N;

wire [(N*32)-1:0] 	adrs_N_tags;
wire [N-1:0] 	   	adrs_N_valids;
wire [N-1:0] 	   	adrs_N_dirtys;
wire 						adrs_N_use;

reg  [(4*b)-1:0] 		valid_bytes;

reg  [(32*b)-1:0] 	write_data;
wire [(32*b)-1:0] 	read_data;

wire 						mem_operation_done;

always @(posedge clk) begin
	if (rst) begin
		{
			op,
			adrs,

			set_valid,
			set_tag,
			set_dirty,
			set_use,

			use_manual_N,
			manual_N,

			mem_operation,

			valid_bytes,
							 
			write_data
			} <= 0;

	end
end

// test program

initial begin
	rst = 1;
	#4;
	rst = 0;
	#4
	count_up();
	//fill_with_conseq_nums();

	//send_block(128'b0, 32'd0);

	//send_word(32'd0, 32'd0);
	//send_word(32'd0, 32'd4);
	//send_word(32'd0, 32'd8);
	//send_word(32'd0, 32'd12);

	//send_byte(8'd0, 32'd0);
	//send_byte(8'd1, 32'd1);
	//send_byte(8'd2, 32'd2);
	//send_byte(8'd3, 32'd3);
end

// tasks and functions
task count_up;
begin
	integer i = 0;
	while (1) begin
		send_byte(i, i);
		i = i+1;
	end
end
endtask

task fill_with_conseq_nums;
begin
	integer i;
	for (i=0; i<(C*4); i=i+1) begin
		send_byte(i, i);
	end
end
endtask

task send_block(input [128:0] block_to_send, input [31:0] i_adrs);
begin

	lookup(i_adrs);

	op = `write_op;
	adrs = i_adrs;

	set_valid = 1'b1;
	set_tag = 1'b1;
	set_dirty = 1'b1;
	set_use = 1'b1;

	valid_bytes = 16'hffff;
	write_data = block_to_send;

	mem_operation = 1;
	@(posedge mem_operation_done) mem_operation = 0;
	@(negedge mem_operation_done);

end
endtask

task send_word(input [31:0] word_to_send, input [31:0] i_adrs);
begin

	lookup(i_adrs);

	op = `write_op;
	adrs = i_adrs;

	set_valid = 1'b1;
	set_tag = 1'b1;
	set_dirty = 1'b1;
	set_use = 1'b1;

	valid_bytes = 16'b0;
	valid_bytes[adrs[3:2]*4 +: 4] = 4'hf;
	write_data = 128'b0;
	write_data[adrs[3:2]*32 +: 32] = word_to_send;

	mem_operation = 1;
	@(posedge mem_operation_done) mem_operation = 0;
	@(negedge mem_operation_done);

end
endtask

task send_byte(input [7:0] byte_to_send, input [31:0] i_adrs);
begin

	lookup(i_adrs);

	op = `write_op;
	adrs = i_adrs;

	set_valid = 1'b1;
	set_tag = 1'b1;
	set_dirty = 1'b1;
	set_use = 1'b1;

	valid_bytes = 16'b0;
	valid_bytes[adrs[3:0]] = 1'b1;
	write_data = 128'b0;
	write_data[adrs[3:0]*8 +: 8] = byte_to_send;

	mem_operation = 1;
	@(posedge mem_operation_done) mem_operation = 0;
	@(negedge mem_operation_done);

end
endtask

task lookup(input [31:0] i_adrs);
begin
	op = `lookup_op;
	adrs = i_adrs;

	mem_operation = 1;
	@(posedge mem_operation_done) mem_operation = 0;
	@(negedge mem_operation_done);
end
endtask


// modules
cache 
#(
	.C								(C), // capacity (words)
	.b								(b), // block size (words in block)
	.N								(N)  // degree of associativity
) 
cache
(
	.i_clk						(clk),
	.i_rst						(rst),

	.i_op							(op),
	.i_address					(adrs),

	.i_set_valid				(set_valid),
	.i_set_tag					(set_tag),
	.i_set_dirty				(set_dirty),
	.i_set_use					(set_use),

	.i_use_manual_N			(use_manual_N),
	.i_manual_N					(manual_N),

	.i_mem_operation			(mem_operation),

	.o_hit_occurred			(hit_occurred),
	.o_empty_found				(empty_found),
	.o_clean_found				(clean_found),
	.o_adrs						(adrs_target_N),
	.o_target_N					(target_N),

	.o_adrs_N_tags				(adrs_N_tags), // it contains the full addresses, not just the tags, for ease of use outside
	.o_adrs_N_valids			(adrs_N_valids),
	.o_adrs_N_dirtys			(adrs_N_dirtys),
	.o_adrs_N_use				(adrs_N_use),

	.i_valid_bytes				(valid_bytes),

	.i_write_data				(write_data),
	.o_read_data				(read_data),

	.o_mem_operation_done	(mem_operation_done)
);
endmodule
