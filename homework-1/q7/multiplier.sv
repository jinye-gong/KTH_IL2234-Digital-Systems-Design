module multiplier #(parameter N=4) (
  input  logic signed [N-1:0] a, b,
  output logic signed [2*N-1:0] product


);


  logic [N-1:0]   pp        [N-1:0];
  logic [2*N-1:0] shifted_pp[N-1:0];
  logic [2*N-1:0] sum       [N-1:0];



  genvar i;
  generate
    for(i=0; i<N; i=i+1) begin : gen_pp
      assign pp[i] = a & {N{b[i]}};
    end
  endgenerate


  generate
    for(i=0; i<N; i=i+1) begin : gen_shift
      assign shifted_pp[i] = {{N{pp[i][N-1]}}, pp[i]} << i;
    end
  endgenerate


  assign sum[0] = shifted_pp[0];
  generate
    for(i=1; i<N; i=i+1) begin : gen_add
      ripple_carry_adder #(2*N) rca (
        .A(sum[i-1]),
        .B(shifted_pp[i]),
        .c_in(1'b0),
        .SUM(sum[i]),
        .c_out()
      );
    end
  endgenerate

  assign product = sum[N-1];

endmodule
