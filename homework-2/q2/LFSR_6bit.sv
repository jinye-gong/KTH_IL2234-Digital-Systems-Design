module LFSR_6bit (                                                                                     
        input logic clk, rst_n,                                                                        
        input logic sel,                                                                               
        input logic [5:0] p_in,                                                                        
        output logic [5:0] p_out                                                                       
);                                                                                                     
                                                                                                       
always_ff @(posedge clk or negedge rst_n) begin                                                        
        if (!rst_n) begin                                                                              
                p_out <= 6'd0;                                                                         
        end else begin                                                                                 
                if(sel == 1'b0) begin                                                                  
                        // Parallell load input                                                        
                        p_out <= p_in;                                                                 
                                                                                                       
                end else begin                                                                         
                        // Sequential shift.                                                           
                        // P_out 0  1      2   3        4   5                                          
                        //     {x5 (x5^x0) x1  (x5^x2) x3  x4}                                         
                        p_out <= {                                                                     
                                        p_out[4:3],                                                    
                                        (p_out[2] ^ p_out[5]),                                         
                                        p_out[1],                                                      
                                        (p_out[0] ^ p_out[5]),                                         
                                        p_out[5]                                                       
                                };                                                                     
                                                                                                       
                end                                                                                    
                                                                                                       
        end                                                                                            
end                                                                                                    
                                                                                                       
                                                                                                       
endmodule                                                                                              
~             
