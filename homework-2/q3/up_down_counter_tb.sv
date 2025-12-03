module up_down_counter_tb;                                                                             
                                                                                                       
localparam N = 4;                                                                                      
                                                                                                       
logic clk, rst_n, up_down, load, carry_out;                                                            
logic [N-1:0] input_load, count_out;                                                                   
                                                                                                       
                                                                                                       
up_down_counter #(.N(N)) DUT(                                                                          
        .clk(clk),                                                                                     
        .rst_n(rst_n),                                                                                 
        .up_down(up_down),                                                                             
        .load(load),                                                                                   
        .input_load(input_load),                                                                       
        .count_out(count_out),                                                                         
        .carry_out(carry_out)                                                                          
);                                                                                                     
                                                                                                       
initial begin                                                                                          
        clk = 0;                                                                                       
        forever #5 clk = ~clk;                                                                         
end                                                                                                    
                                                                                                       
initial begin                                                                                          
        // case 0: rst_n = 0 means RESET                                                               
        rst_n = 1'b0;                                                                                  
        @(negedge clk);                                                                                
                                                                                                       
        // case 1: load = 1 means LOAD input.                                                          
        rst_n = 1'b1;                                                                                  
        load = 1'b1;                                                                                   
        input_load = 4'b1110;                                                                          
        @(posedge clk);                        

        // case 2: updown = 1 means increment.                                                         
        load = 1'b0;                                                                                   
        up_down = 1'b1;                                                                                
        @(posedge clk);                                                                                
                                                                                                       
        // count_out is now = 1111 which means that                                                    
        // after this clk wrap occurs carry_out becomes 1.                                             
        @(posedge clk);                                                                                
                                                                                                       
        // Reload input prepare for subtraction.                                                       
        rst_n = 1'b1;                                                                                  
        load = 1'b1;                                                                                   
        input_load = 4'b0001;                                                                          
        @(posedge clk);                                                                                
                                                                                                       
        // case 3: updown = 0 means decrement.                                                         
        load = 1'b0;                                                                                   
        up_down = 1'b0;                                                                                
        @(posedge clk);                                                                                
                                                                                                       
        // count_out is now = 0000 which means that                                                    
        // after this clk wrap occurs carry_out becomes 1.                                             
        @(posedge clk);                                                                                
end                                                                                                    
                                                                                                       
                                                                                                       
endmodule     
