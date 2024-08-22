```verilog
/* 
 * Do not change Module name 
*/
module main;
    reg [31:0] adrs;
    integer i;
    localparam num_of_words = 4;
  initial 
    begin
        adrs = 32'h00000029;
        print_adrs_info(adrs);
        analyze_block(0);
        
        $display();
        $finish ;
    end
    
    task analyze_block(input integer extra);
        begin
            $display("Exploring block of size %0d words:", num_of_words);
            $display("total num of bytes in block: %0d", num_of_words*4);
            $display("num of bits required to address all bytes: %0d", $clog2(num_of_words*4));
            adrs = 32'h00000000;
            i = 32'd0;
            for (i=0; i<num_of_words*4+extra; i=i+1) begin
                if (adrs[1:0] == 2'b00) begin
                    $display("----------------------");
                    $display("word start: %0d", adrs[$clog2(num_of_words*4)-1:2]*32, ", end: %0d", (adrs[$clog2(num_of_words*4)-1:2]+1)*32-1);
                end
                // $write("i=%0d", i);
                // $write(", adrs = %h", adrs);
                $write("adrs: %0d", adrs);
                $write(", word_byte_index=%0d", adrs[1:0]);
                $write(", block_byte_index=%0d", adrs[$clog2(num_of_words*4)-1:0]);
                // $write(", 128_byte_index=%0d", adrs[3:0]);
                // $write(", 128_word_index=%0d", adrs[3:2]);
                // $write(", word_half=%0d", adrs[1]);
                // $write(", 128_half=%0d", adrs[3:1]);
                // $write(", 128_64_index=%0d", adrs[3]);
                adrs=adrs+1;
                
                $display();
            end
        end
    endtask

    task print_adrs_info(input [31:0] adrs_i);
        begin
            $display("adrs: h-%h, d-%0d", adrs_i, adrs_i);
            $display("index word-byte: %0d", get_index_word_byte(adrs_i));
            $display("index of byte in %0d-word block: %0d", num_of_words, adrs_i[$clog2(num_of_words*4)-1:0]);
            $display();
        end
    endtask
    
    function integer get_index_word_byte (input [31:0] adrs_i);
            get_index_word_byte = adrs[1:0];
    endfunction
    function integer get_index_2word_byte (input [31:0] adrs_i);
            get_index_2word_byte = adrs[2:0];
    endfunction
    function integer get_index_4word_byte (input [31:0] adrs_i);
            get_index_4word_byte = adrs[4:0];
    endfunction

endmodule
```


old
```verilog
/* 
 * Do not change Module name 
*/
module main;
    reg [31:0] adrs;
    integer i;
  initial 
    begin
        adrs = 32'h80000000;
        $display("adrs: %h", adrs);
        $display("adrs[1:0]: %d", adrs[1:0]);
        $display();
        
        for (i=0; i<40; i=i+1) begin
            if (adrs[1:0] == 2'b00) begin
                $display();
                $display("word start: %0d", adrs[3:2]*32, ", end: %0d", (adrs[3:2]+1)*32-1);
            end
            $write("i=%0d", i);
            $write(", adrs = %h", adrs);
            $write(", word_byte_index=%0d", adrs[1:0]);
            $write(", 128_byte_index=%0d", adrs[3:0]);
            $write(", 128_word_index=%0d", adrs[3:2]);
            $write(", word_half=%0d", adrs[1]);
            $write(", 128_half=%0d", adrs[3:1]);
            $write(", 128_64_index=%0d", adrs[3]);
            adrs=adrs+1;
            
            $display();
        end
        
        $finish ;
    end
endmodule
```