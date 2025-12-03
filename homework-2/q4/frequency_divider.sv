module frequency_divider (                                                                             
        input logic clk, rst_n,                                                                        
        output logic divider_out                                                                       
);                                                                                                     
                                                                                                       
localparam N = 4;                                                                                      
logic [N-1:0] cout;                                                                                    
logic [15:0] count_out;                                                                                
logic [15:0] input_load;                                                                               
logic ld, reset;                                                                                       
                                                                                                       
assign ld = cout[3] | reset;                                                                           
                                                                                                       
genvar i;                                                                                              
generate                                                                                               
        for (i = 0; i < N; i = i+1) begin : upc                                                        
                up_down_counter #(.N(N)) upc1(                                                         
                        .clk(clk),                                                                     
                        .rst_n(rst_n),                                                                 
                        .load(ld),                                                                     
                        .carry_in((i == 0) ? 1'b1 : cout[i-1]),                                        
                        .input_load(input_load[((i+1)*4-1):(i*4)]),                                    
                        .count_out(count_out[((i+1)*4-1):(i*4)]),                                      
                        .carry_out(cout[i])                                                            
                );                                                                                     
        end                                                                                            
endgenerate                                      

// Operation for swapping the frequency.                                                               
// We need to take the complement of 18 and 866 which becomes:                                         
// Divider 0: 2^16 - 18  = 65518                                                                       
// Divider 1: 2^16 - 866 = 64670                                                                       
always_ff @(posedge clk or negedge rst_n) begin                                                        
        if(!rst_n) begin                                                                               
                // needs a way to tell all counters to load.                                           
                reset <= 1'b1;                                                                         
                input_load <= 16'd65518;                                                               
        end else begin                                                                                 
                reset <= 1'b0;                                                                         
                if(ld) begin                                                                           
                        // highest Co is 1 means LOAD all counters.                                    
                        // by checking for (~divider_out) we prefire the next                          
                        // correct load value before the actual divider_out is                         
                        // updated on next clock cycle.                                                
                        input_load <= (~divider_out) ? 16'd64670 : 16'd65518;                          
                end                                                                                    
        end                                                                                            
end                                                                                                    
                                                                                                       
// Operation for Toggling the Flip Flop.                                                               
always_ff @(posedge clk or negedge rst_n) begin                                                        
        if(!rst_n) begin                                                                               
                divider_out <= 1'b0;                                                                   
        end else begin                                                                                 
                if(ld) begin                                                                           
                        // Toggle output from TFF when highest Co is 1.                                
                        divider_out <= (~divider_out);                                                 
                end                                                                                    
        end                                                                                            
end                                                                                                    
endmodule                                                                                              
           

/* 4-bit UP with Cin. */                                                                               
module up_down_counter #(parameter N = 4) (                                                            
        input logic clk, rst_n, up_down, load, carry_in,                                               
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
                end                                                                                    
                else if (carry_in) begin                                                               
                        count_out <= count_out + 1;                                                    
                end                                                                                    
        end                                                                                            
end                                                                                                    
                                                                                                       
assign carry_out = carry_in & (&count_out);                                                            
endmodule  
