`timescale 1us / 1ns
`include "cache_ops.vh"

// logs defs
`undef log_substates
`define log_valToWrite

`define log_L1_data
`define log_L2_data
`define log_phy_data
`define log_vir_data

module tb_hierarchy;
// capacity (total words)
localparam L1_C  = 8;
localparam L2_C  = 16;
// block size (words per block)
localparam L1_b  = 2;
localparam L2_b  = 4;
// degree of associativity (blocks per set)
localparam L1_N  = 1;
localparam L2_N  = 2;


reg clk = 0, rst = 0, mem_op = 0;
reg [2:0] op;
reg [31:0] adrs;
reg [(4*L1_b)-1:0] valid_bytes;
reg [(32*L1_b)-1:0] w_data;
wire [(32*L1_b)-1:0] r_data;
wire done;



integer state;
localparam idle_st 				= 0,
			  setup_main_mem_st  = 1,
			  write_test_vals_st = 2,
			  read_test_vals_st 	= 3;

wire manual = state == setup_main_mem_st;

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
integer sub_state;
localparam init   = 0,
			  busy   = 1,
			  finish = 2;

always #1 clk = ~clk;
	  
initial begin
	rst = 0;
	#10
	rst = 1;
	#10
	rst = 0;
end

always @(posedge clk) begin
	if (rst) begin
		{clk, mem_op, op, adrs, valid_bytes, w_data, test_val, sub_state, state} <= 0;
		{m_op_manual, m_address_manual, m_valid_bytes_manual, m_mem_operation_manual} <= 0;
	end else begin
		case (state)

			idle_st: begin
				state <= setup_main_mem_st;
			end

			setup_main_mem_st: begin
				case (sub_state)
					init: begin
						m_write_data_manual <= 0;
						m_op_manual	     				  <= `write_op;
						m_mem_operation_manual		  <= 1'b1;
						m_valid_bytes_manual			  <= {(4*L2_b){1'b1}};

						sub_state	     				  <= busy;
					end
					busy: begin
						if (m_mem_operation_done) begin
							m_mem_operation_manual <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!m_mem_operation_done) begin
							sub_state <= init;
							if (m_address_manual+((32*L2_b)/8) < L2_C*4) begin
								m_address_manual <= m_address_manual+((32*L2_b)/8);
							end else begin
								m_address_manual <= 0;
								state <= write_test_vals_st;
							end
						end
					end
				endcase
			end

			write_test_vals_st: begin
				case (sub_state)
					init: begin
						w_data [(((adrs % (4*L1_b))+1)*8)-1 -: 8] <= test_val;
						// mul by 4 to get bytes per word, then by 8 to get bits per byte
						op 			     				  <= `write_op;
						mem_op    		  				  <= 1'b1;
						valid_bytes 	  				  <= {(4*L1_b){1'b0}};
						valid_bytes[adrs % (4*L1_b)] <= 1'b1;

						sub_state	     				  <= busy;
					end
					busy: begin
						if (done) begin
							mem_op <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!done) begin
							sub_state <= init;
							if (test_val < L2_C*4*10) begin
								test_val <= test_val+1;
								adrs <= adrs+1;
							end else begin
								test_val <= 0;
								adrs <= 0;
								state <= read_test_vals_st;
							end
						end
					end
				endcase
			end

			read_test_vals_st: begin
				case (sub_state)
					init: begin
						op 			     				  <= `read_op;
						mem_op    		  				  <= 1'b1;
						valid_bytes 	  				  <= {(4*L1_b){1'b0}};
						valid_bytes[adrs % (4*L1_b)] <= 1'b1;

						sub_state	     				  <= busy;
					end
					busy: begin
						if (done) begin
							mem_op <= 1'b0;

							sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!done) begin
							sub_state <= init;
							if (adrs < L2_C*4) begin
								adrs <= adrs+1;
							end else begin
								adrs <= 0;
								state <= idle_st;
							end
						end
					end
				endcase
			end
		endcase
	end
end


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
	.C(L2_C), // capacity (words)
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
