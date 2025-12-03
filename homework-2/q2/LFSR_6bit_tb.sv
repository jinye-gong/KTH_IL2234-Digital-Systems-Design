module LFSR_6bit_tb;                                                                                   
                                                                                                       
logic clk, rst_n, sel;                                                                                 
logic [5:0] p_in, p_out;                                                                               
                                                                                                       
LFSR_6bit DUT(                                                                                         
        .clk(clk),                                                                                     
        .rst_n(rst_n),                                                                                 
        .sel(sel),                                                                                     
        .p_in(p_in),                                                                                   
        .p_out(p_out)                                                                                  
);                                                                                                     
                                                                                                       
initial begin                                                                                          
        clk = 0;                                                                                       
        forever #5 clk = ~clk;                                                                         
end                                                                                                    
                                                                                                       
initial begin                                                                                          
        // case 0: rst_n = 0 means RESET                                                               
        rst_n = 1'b0;                                                                                  
        sel = 1'b0;                                                                                    
        p_in = 6'b0;                                                                                   
        @(negedge clk);                                                                                
                                                                                                       
        // case 1: rst_n = 1 and sel = 0 means parallell load.                                         
        rst_n = 1'b1;                                                                                  
        sel = 1'b0;                                                                                    
        p_in = 6'b000111;                                                                              
        @(posedge clk); 

 // case 2: rst_n = 1 and sel = 1 means sequential shift.                                       
        // with xor result should be 6'b001110                                                         
        rst_n = 1'b1;                                                                                  
        sel = 1'b1;                                                                                    
        p_in = 6'b000111;                                                                              
        @(posedge clk);                                                                                
                                                                                                       
        // case 2.5: rst_n = 1 and sel = 1 means sequential shift.                                     
        // with xor result should be 6'b000101                                                         
        // LOAD: but first load the new value in p_in.                                                 
        rst_n = 1'b1;                                                                                  
        sel = 1'b0;                                                                                    
        p_in = 6'b100111;                                                                              
        @(posedge clk);                                                                                
                                                                                                       
        // case 2.5: rst_n = 1 and sel = 1 means sequential shift.                                     
        // with xor result should be 6'b000101                                                         
        rst_n = 1'b1;                                                                                  
        sel = 1'b1;                                                                                    
        p_in = 6'b100111;                                                                              
        @(posedge clk);                                                                                
                                                                                                       
                                                                                                       
                                                                                                       
end                                                                                                    
endmodule                        
