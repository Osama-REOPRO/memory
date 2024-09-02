notes evacuated from cache_hierarchy read start state, we were deciding which read state to go to

// we read L1 either if it hit or if it needs to be evacuated, 
// likewise for L2, we read it if it hit or if it needs evacuateion, 
// we read main only if both miss
//
// if L2 didn't hit also, do we need to read it?
// probably only if no empty or clean, if empty
// or clean found no need to read it, if not
// empty we will need to read to evacuate
//
// no need to read L1 because empty or clean
// but should we read L2 or main?
// if we are writing a few bytes out of the block
// then we need to fetch the rest of the bytes,
// that is why we need to read when no hit occures
// in write_op's
//
// Note: you might object: what if we do need to read
// main but you are sending me to L2? 
// Answer: here we are only determining the beginning, we
// will go to later read stages from there!



					read_done_st: begin
						case (i_op)
							`write_op: begin
								state <= write_st;
							end
							`read_op: begin
								if (hit_occurred[1]) begin
									o_read_data <= read_data_L1;
									state <= done_st;
								end else if (hit_occurred[2]) begin
									o_read_data <= read_data_L2[i_address[3]*64 +: 64]; // half data read from L2
									state <= write_st;
								end else begin
									o_read_data <= i_read_data[i_address[3]*64 +: 64]; // data read from main memory
									state <= write_st;
								end
							end
						endcase
						sub_state <= 0;
					end
				



			lookup_L2_evac_st: begin
				case (cache_sub_state)
					init: begin
						// non_current_adrs_lookup_occurred_L2 <= 1'b1;
						use_manual_adrs <= 1'b1;
						adrs_manual <= adrs_target_N_L1;

						op			  <= `lookup_op;
						mem_operation[2] <= 1'b1;

						cache_sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							sub_state <= write_L2_from_L1_st;
							cache_sub_state <= init;
						end
					end
				endcase
			end


			lookup_L2_second_st: begin
				// lookup current address again after we looked up conflict address
				// done before write L2 from main if an evac occurred
				case (cache_sub_state)
					init: begin
						// non_current_adrs_lookup_occurred_L2 <= 1'b0;
						use_manual_adrs <= 1'b0; // the whole point is that we want to undo this
						op			  <= `lookup_op;
						mem_operation[2] <= 1'b1;

						cache_sub_state 	  <= busy;
					end
					busy: begin
						if (mem_operation_done[2]) begin
							mem_operation[2] <= 1'b0;

							cache_sub_state 	  <= finish;
						end
					end
					finish: begin
						if (!mem_operation_done[2]) begin
							//									sub_state <= write_L2_from_main_st;
							sub_state <= 
								!hit_occurred[2] ? write_L2_from_main_st :  // if we missed, then the data must come from above
								write_needed_main ? write_Main_st : 
								write_done_st;
							cache_sub_state <= init;
						end
					end
				endcase
			end


    // from write_Main_st
    if (evac_needed_L1 && evac_needed_L2) begin
        // combine dirty data from lower with dirty data from upper
        // but what if we are evacuating L1 to one address and L2
        // to a different address? which is what always occurrs!?
        o_write_data <= read_data_L2;
        o_write_data[i_address[3]*64 +: 64] <= read_data_L1;
        o_valid_bytes <= {(4*L2_b){1'b1}}; // write all bytes
    end else if (evac_needed_L2) begin
        o_write_data <= read_data_L2;
        o_valid_bytes <= {(4*L2_b){1'b1}}; // write all bytes
    end else begin
        // the only other case is an evac from L1 right up to Main
        // wait we have inclusive policy, that just isn't a thing
        o_write_data[(block_offset_in_adrs_L2*4*8) +: 8*4*L1_b] <= read_data_L1; // todo: this is iffy, test it
        o_valid_bytes <= {(4*L2_b){1'b0}};
        o_valid_bytes[(block_offset_in_adrs_L2*4) +: 4*L1_b] <= {(4*L2_b){1'b1}}; // todo: test this
    end
