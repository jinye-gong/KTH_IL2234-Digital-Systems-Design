module sin_controller_tb;

    // Declare signals
    logic clk;
    logic rst_n;
    logic start;
    logic co;
    logic done;
    logic load_xpowertwo;
    logic init_xpowertwo;
    logic load_mult_reg;
    logic init_mult_reg;
    logic load_result;
    logic init_result;
    logic inc_counter;
    logic init_counter;
    logic sel_mult_in;

    // Instantiate the sin_controller module
    sin_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .co(co),
        .done(done),
        .load_xpowertwo(load_xpowertwo),
        .init_xpowertwo(init_xpowertwo),
        .load_mult_reg(load_mult_reg),
        .init_mult_reg(init_mult_reg),
        .load_result(load_result),
        .init_result(init_result),
        .inc_counter(inc_counter),
        .init_counter(init_counter),
        .sel_mult_in(sel_mult_in)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        start = 0;
        co = 0;

        // Apply reset
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Test start signal
        #10 start = 1;
        #10 start = 0;

        // Test when done is triggered
        #50 co = 1;  // Simulate co signal for ADD state transition

        // End simulation
        #100 $finish;
    end

endmodule
