module conversion_system_tb ();
  
  logic clk, rst_n, x, z_mealy, z_moore;

  conversion_system_mealy mealy_fsm(.clk(clk), .rst_n(rst_n), .x(x), .z(z_mealy));
  conversion_system_moore moore_fsm(.clk(clk), .rst_n(rst_n), .x(x), .z(z_moore));

	// …
	// Add your description here

  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 0;
    x = 1;
    #10 rst_n = 1;
    #10  x = 1;
    #10 x = 0;
    #10 x = 0;
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;
    #10 x = 0;
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;
    #10 $finish;
  end



	// …

endmodule