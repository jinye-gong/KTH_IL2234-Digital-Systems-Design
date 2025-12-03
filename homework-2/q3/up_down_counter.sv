module up_down_counter #(parameter N = 4) (                                                            
        input logic clk, rst_n, up_down, load,                                                         
        input logic [N-1:0] input_load,                                                                
        output logic [N-1:0] count_out,                                                                
        output logic carry_out                                                                         
);                                                                                                     
                                                                                                       
always_ff @(posedge clk or negedge rst_n) begin                                                        
        if(!rst_n) begin                                                                               
                count_out <= '0;                                                                       
        end else begin                                                                                 
                if (load) begin                                                                        
                        count_out <= input_load;                                                       
                end else begin                                                                         
                        // up_down is 1 (true) count up.                                               
                        // up_down is 0 (false) count down.                                            
                        count_out <= up_down ? (count_out+1) : (count_out-1);                          
                end                                                                                    
        end                                                                                            
end                                                                                                    
                                                                                                       
// If up_down is 0 (down) then carry_out is 1 when wrap around 0                                       
// gives 1111 which means AND between all count_out bits.                                              
// Else If up_down is 1 (up) then carry_out becomes 1 when                                             
// wrap from maximum becomes 0, meaning NAND of count_out.                                             
assign carry_out = up_down ? (~(&count_out)) : (&count_out);                                           
endmodule                                                                                              
~           
