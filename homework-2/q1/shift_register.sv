module shift_register #(parameter N=4) (                                                               
        input logic clk,                                                                               
                    rst_n,                                                                             
                    serial_parallel,                                                                   
                    load_enable,                                                                       
                    serial_in,                                                                         
        input logic  [N-1:0] parallel_in,                                                              
        output logic [N-1:0] parallel_out,                                                             
        output logic serial_out                                                                        
);                                                                                                     
                                                                                                       
localparam SERIAL   = 1'b0;                                                                            
localparam PARALLEL = 1'b1;                                                                            
                                                                                                       
always_ff @(posedge clk or negedge rst_n) begin                                                        
        if(!rst_n)                                                                                     
                parallel_out <= {N{1'b0}};                                                             
        else begin                                                                                     
                                                                                                       
                if(load_enable) begin                                                                  
                        case (serial_parallel)                                                         
                                SERIAL   : parallel_out <= {parallel_out[N-2:0], serial_in};                                           PARALLEL : parallel_out <= parallel_in;                                
                                default: parallel_out <= parallel_out;                                 
                        endcase                                                                        
                end                                                                                    
        end                                                                                            
end                                                                                                    
                                                                                                       
assign serial_out = parallel_out[N-1];                                                                 
                                                                                                       
endmodule                        
