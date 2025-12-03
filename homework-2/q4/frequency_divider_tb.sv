module frequency_divider_tb;                                                                           
                                                                                                       
logic clk, rst_n, divider_out;                                                                         
                                                                                                       
frequency_divider DUT (                                                                                
        .clk(clk),                                                                                     
        .rst_n(rst_n),                                                                                 
        .divider_out(divider_out)                                                                      
);                                                                                                     
                                                                                                       
initial begin                                                                                          
        clk = 0;                                                                                       
        forever #5 clk = ~clk;                                                                         
end                                                                                                    
                                                                                                       
initial begin                                                                                          
        // case 0: rst_n = 0 means RESET                                                               
        rst_n = 1'b0;                                                                                  
        @(negedge clk);                                                                                
                                                                                                       
        // case 1: input loaded is now 16'b0;                                                          
        // we will have to wait for                                                                    
        rst_n = 1'b1;                                                                                  
        @(posedge clk);                                                                                
                                                                                                       
                                                                                                       
        // Testbench cant jump in time.                                                                
        // We simply have to try with smaller values                                                   
                                                                                                       
end                                                                                                    
                                                                                                       
endmodule   
