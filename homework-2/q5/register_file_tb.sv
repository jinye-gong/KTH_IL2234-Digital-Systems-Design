odule registerfile_tb;                                                                                
                                                                                                       
localparam BW = 8;                                                                                     
localparam DEPTH = 16;                                                                                 
                                                                                                       
logic clk;                                                                                             
logic rst_n;                                                                                           
logic write_en;                                                                                        
logic [3:0] write_addr;                                                                                
logic [7:0] data_in;                                                                                   
logic [3:0] read_addr1;                                                                                
logic [3:0] read_addr2;                                                                                
logic [7:0] data_out1;                                                                                 
logic [7:0] data_out2;                                                                                 
                                                                                                       
registerfile DUT (                                                                                     
        .clk(clk),                                                                                     
        .rst_n(rst_n),                                                                                 
        .write_en(write_en),                                                                           
        .write_addr(write_addr),                                                                       
        .data_in(data_in),                                                                             
        .read_addr1(read_addr1),                                                                       
        .read_addr2(read_addr2),                                                                       
        .data_out1(data_out1),                                                                         
        .data_out2(data_out2)                                                                          
);                                                                                                     
                                                                                                       
initial begin                                                                                          
        clk = 0;                                                                                       
        forever #5 clk = ~clk;                                                                         
end                                    

initial begin                                                                                          
        rst_n = 0;                                                                                     
        read_addr1 = 0;                                                                                
        read_addr2 = 0;                                                                                
        @(negedge clk);                                                                                
        @(posedge clk);                                                                                
                                                                                                       
        // First we fill all regs with incremented numbers 1,2...256                                   
        // Then we use "random" to take and look at a entry                                            
        // index to that entry should match output.                                                    
        rst_n = 1;                                                                                     
        write_en = 1;                                                                                  
        for(int i = 0; i < DEPTH; i++) begin                                                           
                // 256 (0-255) fits in 8 bits.                                                         
                write_addr = i;                                                                        
                data_in    = i;                                                                        
                @(posedge clk);                                                                        
        end                                                                                            
                                                                                                       
        // Now switch to read mode.                                                                    
        write_en = 0;                                                                                  
                                                                                                       
        repeat (10) begin                                                                              
                read_addr1 = $urandom_range(0, DEPTH-1);                                               
                read_addr2 = $urandom_range(0, DEPTH-1);                                               
                                                                                                       
                @(posedge clk);                                                                        
                                                                                                       
                $display("read_addr_1: %0d, data_out_1: %0d", read_addr1, $unsigned(data_out1));       
                $display("read_addr_2: %0d, data_out_2: %0d", read_addr2, $unsigned(data_out2));       
                                                                                                       
        end                                                                                            
                                                                                                       
        // case STANDBY: (rst_n)                                                                       
        @(posedge clk);                                                                                
                                                                                                       
        // case RESET: (!rst_n)                                                                        
        rst_n = 0;                                                                                     
        @(negedge clk);                                                                                
                                                                                                       
        $finish;                                                                                       
                                                                                                       
end                                                                                                    
endmodule 
