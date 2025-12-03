module input_out_wrapper_tb;
// Testbench code goes here


  logic clk   = 0;
  logic rst_n = 0;
  always #5 clk = ~clk; 

  logic        dataReady = 0;
  logic [15:0] dataIn    = '0;
  logic        dataAccept;


  logic        imc_start;    
  logic        imc_ready = 0;
  logic [15:0] a, b, c, d;   


  logic [15:0] a_in, b_in, c_in, d_in; 
  logic        startTransmit = 0;
  logic        outAvail;
  logic        request;
  logic        grant = 0;
  logic        outReady;
  logic        outAccepted = 0;
  logic [15:0] dataOut;


  assign a_in = a;
  assign b_in = b;
  assign c_in = c;
  assign d_in = d;

  
iw_top dut1 (
    .clk(clk), 
    .rst_n(rst_n),
    .dataReady(dataReady), 
    .dataIn(dataIn), 
    .dataAccept(dataAccept),
    .imc_ready(imc_ready), 
    .imc_start(imc_start),
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d)
);



  ow_top dut2 (
    .clk           (clk),
    .rst_n         (rst_n),
    .imc_ready     (imc_ready),
    .a_in          (a_in),
    .b_in          (b_in),
    .c_in          (c_in),
    .d_in          (d_in),
    .startTransmit (startTransmit),
    .outAvail      (outAvail),
    .request       (request),
    .grant         (grant),
    .dataOut       (dataOut),
    .outReady      (outReady),
    .outAccepted   (outAccepted)
);



  initial begin
    rst_n = 0;
    repeat (4) @(posedge clk);
    rst_n = 1;
  end


  initial begin

    @(posedge rst_n);


    @(posedge clk); dataIn <= 16'h0011; dataReady <= 1;
    @(posedge clk); dataReady <= 0;


    @(posedge clk); dataIn <= 16'h0022; dataReady <= 1;
    @(posedge clk); dataReady <= 0;


    @(posedge clk); dataIn <= 16'h0033; dataReady <= 1;
    @(posedge clk); dataReady <= 0;


    @(posedge clk); dataIn <= 16'h0044; dataReady <= 1;
    @(posedge clk); dataReady <= 0;
  end


  initial begin
    @(posedge rst_n);


    grant = 0;


    wait (imc_start === 1'b1);


    repeat (3) @(posedge clk);


    grant <= 1;


    imc_ready <= 1;
    @(posedge clk);
    imc_ready <= 0;


    @(posedge clk);
    startTransmit <= 1;
    @(posedge clk);
    startTransmit <= 0;


    forever begin
      @(posedge clk);
      if (outReady) begin
        outAccepted <= 1;
        @(posedge clk);
        outAccepted <= 0;
      end
    end
  end




endmodule