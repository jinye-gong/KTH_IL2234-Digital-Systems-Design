module shift_register_tb;                                                                              
                                                                                                       
localparam N = 4;                                                                                      
                                                                                                       
logic clk,                                                                                             
        rst_n,                                                                                         
        serial_parallel,                                                                               
        load_enable,                                                                                   
        serial_in,                                                                                     
        serial_out;                                                                                    
                                                                                                       
logic [N-1:0] parallel_in;                                                                             
logic [N-1:0] parallel_out;                                                                            
                                                                                                       
shift_register #(.N(N)) DUT(                                                                           
        .clk(clk),                                                                                     
        .rst_n(rst_n),                                                                                 
        .serial_parallel(serial_parallel),                                                             
        .load_enable(load_enable),                                                                     
        .serial_in(serial_in),                                                                         
        .parallel_in(parallel_in),                                                                     
        .parallel_out(parallel_out),                                                                   
        .serial_out(serial_out)                                                                        
);                                                                                                     
                                                                                                       
initial begin                                                                                          
        clk = 0;                                                                                       
        forever #5 clk = ~clk;                                                                         
end                            
initial begin                                                                                          
                                                                                                       
        rst_n       = 1'b0;                                                                            
        load_enable = 1'b0;                                                                            
        serial_in   = 1'b0;                                                                            
        parallel_in = 4'b0000;                                                                         
        serial_parallel = 1'b0;                                                                        
        @(posedge clk);                                                                                
        @(posedge clk);                                                                                
                                                                                                       
        rst_n       = 1'b1;                                                                            
        @(posedge clk);                                                                                
                                                                                                       
                                                                                                       
        // serial in & load enable                                                                     
        load_enable = 1'b1;                                                                            
        serial_in   = 1'b1;                                                                            
        serial_parallel = 1'b0;                                                                        
                                                                                                       
        @(posedge clk);                                                                                
                                                                                                       
        // parallel_in & load enable                                                                   
        parallel_in = 4'b0100;                                                                         
        serial_parallel = 1'b1;                                                                        
                                                                                                       
        // set highest bit for serial_out                                                              
        @(posedge clk);                                                                                
        parallel_in = 4'b1000;                                                                         
                                                                                                       
        @(posedge clk);                                                                                
                                                                                                       
        // !load_enable                                                                                
        load_enable = 1'b0;                                                                            
                                                                                                       
        @(posedge clk);                                                                                
        @(posedge clk);                                                                                
                                                                                                       
        // load_enable & !rst_n                                                                        
        load_enable = 1'b1;                                                                            
        rst_n       = 1'b0;                                                                            
                                                                                                       
                                                                                                       
        @(posedge clk);                                                                                
                                                                                                       
end  

endmodule
