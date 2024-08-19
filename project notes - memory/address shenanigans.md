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
            adrs=adrs+1;
            
            $display();
        end
        
        $finish ;
    end
endmodule
```