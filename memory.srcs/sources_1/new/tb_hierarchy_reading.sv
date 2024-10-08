`timescale 1ns / 1ps
`include "cache_ops.vh"

module tb_hierarchy_reading;

// capacity (total words)
localparam L1_C  = 8;
localparam L2_C  = 16;
// block size (words per block)
localparam L1_b  = 2;
localparam L2_b  = 4;
// degree of associativity (blocks per set)
localparam L1_N  = 1;
localparam L2_N  = 2;

localparam main_C = 64;

reg clk = 0, rst = 0, mem_op = 0;
reg [2:0] op;
reg [31:0] adrs;
reg [(4*L1_b)-1:0] valid_bytes;
reg [(32*L1_b)-1:0] w_data;
wire [(32*L1_b)-1:0] r_data;
reg [7:0] r_byte;
wire done;

reg manual;

// connections between cache and main mem

wire [2:0] m_op_cache;
reg  [2:0] m_op_manual;
wire [2:0] m_op = manual? m_op_manual : m_op_cache;

wire [31:0] m_address_cache;
reg  [31:0] m_address_manual;
wire [31:0] m_address = manual? m_address_manual : m_address_cache;

wire [(4*L2_b)-1:0] m_valid_bytes_cache;
reg  [(4*L2_b)-1:0] m_valid_bytes_manual;
wire [(4*L2_b)-1:0] m_valid_bytes = manual? m_valid_bytes_manual : m_valid_bytes_cache;

wire [(32*L2_b)-1:0] m_write_data_cache;
reg  [(32*L2_b)-1:0] m_write_data_manual;
wire [(32*L2_b)-1:0] m_write_data = manual? m_write_data_manual : m_write_data_cache;

wire [(32*L2_b)-1:0] m_read_data;

wire m_mem_operation_cache;
reg  m_mem_operation_manual;
wire m_mem_operation = manual? m_mem_operation_manual : m_mem_operation_cache;

wire m_mem_operation_done;

integer test_val = 0;


always #1 clk = ~clk;


always @(posedge clk) begin
	if (rst) begin
		{clk, mem_op, op, adrs, valid_bytes, w_data, test_val} <= 0;
		{m_op_manual, m_address_manual, m_valid_bytes_manual, m_mem_operation_manual} <= 0;
	end
end

initial begin
	rst = 0;
	#10
	rst = 1;
	#10
	rst = 0;
	#10
	fill_main_ascending_numbers();
	for (integer i=0; i<=main_C*4-1; i=i+1) begin
		read_mem(i);
	end
end

// tasks
task read_mem(input [31:0] adrs_i);
begin
	op = `read_op;
	adrs = adrs_i;
	mem_op = 1;

	@(posedge done) mem_op = 1'b0;
	@(negedge done);
	r_byte = r_data[adrs[2:0]*8 +:8];
end
endtask

task fill_main_ascending_numbers;
begin
	integer i;
	for (i=0; i<=main_C*4-1; i=i+1) begin
		send_byte_main(i, i);
	end
end
endtask

task send_byte_main(input [7:0] byte_to_send, input [31:0] adrs);
begin
	manual = 1;
	m_address_manual = adrs;
	m_write_data_manual[adrs[3:0]*8 +: 8]    = byte_to_send;
	m_op_manual	     	     = `write_op;
	m_mem_operation_manual = 1'b1;
	m_valid_bytes_manual	  = {(4*L2_b){1'b0}};
	m_valid_bytes_manual[adrs[3:0]] = 1'b1;
	
	@(posedge m_mem_operation_done) m_mem_operation_manual = 1'b0;
	@(negedge m_mem_operation_done);	
	
	manual = 0;
end
endtask


cache_hierarchy
#(
	// capacity (total words)
	.L1_C(L1_C),
	.L2_C(L2_C),
	// block size (words per block)
	.L1_b(L1_b),
	.L2_b(L2_b),
	// degree of associativity (blocks per set)
	.L1_N(L1_N),
	.L2_N(L2_N)
)
cache_hierarchy
(
	// essentially same as level 1 cache
	.i_clk(clk),
	.i_rst(rst),

	.i_op(op), 				// read, write
	.i_address(adrs),

	.i_valid_bytes(valid_bytes), 	// valid bytes in read/write data, 1 for each valid byte

	.i_write_data(w_data),
	.o_read_data(r_data),

	.i_mem_operation(mem_op),
	.o_mem_operation_done(done),
	
	// interface with higher memory
	.o_op(m_op_cache),
	.o_address(m_address_cache),

	.o_valid_bytes(m_valid_bytes_cache),

	.o_write_data(m_write_data_cache),
	.i_read_data(m_read_data),

	.o_mem_operation(m_mem_operation_cache),
	.i_mem_operation_done(m_mem_operation_done)
);

cache 
#(
	.C(main_C), // capacity (words)
	.b(L2_b), // block size (words in block)
	.N(1)  // degree of associativity
) 
main_mem
(
	.i_clk(clk),
	.i_rst(rst),

	.i_op(m_op),

	.i_address(m_address),

	.i_set_valid(1'b1),
	.i_set_tag(1'b1),
	.i_set_dirty(1'b0),
	.i_set_use(1'b0),

	.i_use_manual_N(1'b0),
	.i_manual_N(),

	.i_mem_operation(m_mem_operation),

	.o_hit_occurred(),
	.o_empty_found(),
	.o_clean_found(),

	.i_valid_bytes(m_valid_bytes),

	.i_write_data(m_write_data),
	.o_read_data(m_read_data),

	.o_mem_operation_done(m_mem_operation_done)
);
endmodule
