module multiplier (
  input  logic [15:0]a,b,
  output logic [31:0] product
);

// complete the module
    logic [3:0] A_blk [3:0];
    logic [3:0] B_blk [3:0];
    logic [7:0] partial [3:0][3:0];


    assign {A_blk[3], A_blk[2], A_blk[1], A_blk[0]} = a;
    assign {B_blk[3], B_blk[2], B_blk[1], B_blk[0]} = b;


    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin : genA
            for (j = 0; j < 4; j++) begin : genB
                mult4 u_mult4 (
                    .a(A_blk[i]),
                    .b(B_blk[j]),
                    .p(partial[i][j])
                );
            end
        end
    endgenerate


    always_comb begin
        product = 0;
        for (int i = 0; i < 4; i++) begin
            for (int j = 0; j < 4; j++) begin
                product += (partial[i][j] << (4*(i+j)));
            end
        end
    end

endmodule


