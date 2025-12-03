module sum_prod_tb;

  // complete the testbench

  logic [3:0] X [5:0];
  logic [10:0] result;

  sum_prod #(4) UUT (
    .X(X),
    .result(result)
  );  

initial begin

    X[0] = 4'd3;  X[1] = 4'd2;   // 3*2 = 6
    X[2] = 4'd4;  X[3] = 4'd1;   // 4*1 = 4
    X[4] = 4'd7;  X[5] = 4'd5;   // 7*5 = 35
    #10;
    $display("X0=%0d, X1=%0d, X2=%0d, X3=%0d, X4=%0d, X5=%0d => result=%0d",
              X[0], X[1], X[2], X[3], X[4], X[5], result);


    #20;
    $finish;
  end

endmodule
