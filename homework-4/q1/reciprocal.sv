module reciprocal ( input  logic [15:0] x, 
                    output logic [8:0] y);
    
    always_comb begin
        case (x)
            16'h0001: y = 9'h100; // 1
            16'h0002: y = 9'h080;  // 1/2
            16'h0003: y = 9'h055;  // 1/3
            16'h0004: y = 9'h040;  // 1/4
            16'h0005: y = 9'h033;  // 1/5
            16'h0006: y = 9'h02A;  // 1/6
            16'h0007: y = 9'h024; // 1/7
            16'h0008: y = 9'h020; // 1/8
            16'h0009: y = 9'h01C; // 1/9
            16'h000A: y = 9'h019; // 1/10
            16'h000B: y = 9'h017; // 1/11
            16'h000C: y = 9'h015; // 1/12
            16'h000D: y = 9'h013; // 1/13
            16'h000E: y = 9'h012; // 1/14
            16'h000F: y = 9'h011; // 1/15
            default: y = 9'h000; // out of range, return 0
        endcase
    end

endmodule