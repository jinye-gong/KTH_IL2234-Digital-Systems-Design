module moore_1011_tb ();





  property p_w_implies_1011;
   @(posedge clk) disable iff (!rst_n)
    w |-> ($past(j,4) && !$past(j,3) && $past(j,2) && $past(j,1));
endproperty
  assert property (p_w_implies_1011)
    else $error("ASSERT FAIL: w=1 but last 4 inputs are not 1011");


  property p_w_one_cycle;
    @(posedge clk) disable iff (!rst_n)
      w |-> ##1 !w;
  endproperty
  assert property (p_w_one_cycle)
    else $error("ASSERT FAIL: w is not a single-cycle pulse");


  property p_w_rises_from_zero;
    @(posedge clk) disable iff (!rst_n)
      $rose(w) |-> $past(!w);
  endproperty
  assert property (p_w_rises_from_zero)
    else $error("ASSERT FAIL: w did not rise from 0");


  cover property (@(posedge clk) disable iff (!rst_n) $rose(w));

	logic clk;
	logic rst_n;
	logic j;
	logic w;

	moore_1011 dut (
		.clk(clk),
		.rst_n(rst_n),
		.j(j),
		.w(w)
	);

	always #5 clk = ~clk;

	initial begin
		rst_n = 1'b0;
		clk = 1'b0;
		j = 1'b0;

		#12;
		rst_n = 1'b1;

		#10; j = 1'b1;
		#10; j = 1'b0;
		#10; j = 1'b1;
		#10; j = 1'b0;
		#10; j = 1'b1;
		#10; j = 1'b1;
		#10; j = 1'b0;
		#10; j = 1'b1;
		#10; j = 1'b1;

		#20 $stop;
	end

endmodule
