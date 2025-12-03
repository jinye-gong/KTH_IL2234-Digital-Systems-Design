module add_Nbit_gen #(
    parameter int SIZE
) (
    input  logic [SIZE-1:0] a,b,
    input  logic            ci,
    output logic [SIZE-1:0] s,
    output logic            co
);

    logic [SIZE:0] c;


    assign c[0]   = ci;
    assign co     = c[SIZE];


    genvar i;
    generate
    for (i=0; i<SIZE; i=i+1) begin : full_adders
            full_adder fa (
                .a   (a[i]),
                .b   (b[i]),
                .c_in (c[i]),
                .s   (s[i]),
                .c_out  (c[i+1])
            );
        
    end
    endgenerate         

endmodule   