module sin_datapath (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    load_xpowertwo,
    input  logic                    init_xpowertwo,
    input  logic                    load_mult_reg,
    input  logic                    init_mult_reg,
    input  logic                    load_result,
    input  logic                    init_result,
    input  logic                    inc_counter,
    input  logic                    init_counter,
    input  logic                    sel_mult_in,
    output logic                    co,
    input  logic [15:0]             x,
    output logic [15:0]             result
); 

	// …
	// Add your description here
    logic [15:0] data, m_out, term_in;
    logic [15:0] term_out, xr;
    logic [15:0] res_in;
    logic [2:0]  addr;
    logic [31:0] xpowertwo;

    square              square_uut      (   .clk(clk),
                                            .rst_n(rst_n),
                                            .x(x),
                                            .enable(init_xpowertwo),     
                                            .result(xpowertwo)  
                                        );





    register   #(.BIT_WIDTH(16)) regx    (  .clk(clk), 
                                            .rst_n(rst_n),
                                            .init0(), 
                                            .init1(), 
                                            .load(load_xpowertwo), 
                                            .in_value(xpowertwo[30:15]), 
                                            .out_value(xr)
                                        );

    counter                     counter (  .clk(clk), 
                                            .rst_n(rst_n), 
                                            .init0(init_counter), 
                                            .enable(inc_counter), 
                                            .count(addr), 
                                            .co(co)
                                        );

    LUT                          lut     (  .addr(addr), 
                                            .data(data)
                                        );

    mux2to1    #(.BIT_WIDTH(16)) mux     (  .a(xr), 
                                            .b(data), 
                                            .sel(sel_mult_in), 
                                            .out_value(m_out)
                                        );

    multiplier                   mult    (  .a(m_out), 
                                            .b(term_out), 
                                            .out_value(term_in)
                                        );
    
    register   #(.BIT_WIDTH(16))mult_reg (  .clk(clk), 
                                            .rst_n(rst_n), 
                                            .init0(), 
                                            .init1(init_mult_reg), 
                                            .init_value(x), 
                                            .load(load_mult_reg), 
                                            .in_value(term_in), 
                                            .out_value(term_out)
                                        );
    
    adder      #(.BIT_WIDTH(16)) add     (  .a(term_out), 
                                            .b(result), 
                                            .count(addr), 
                                            .sum(res_in), 
                                            .c_out()
                                        );
    
    register   #(.BIT_WIDTH(16))result_reg(  .clk(clk), 
                                            .rst_n(rst_n), 
                                            .init0(), 
                                            .init1(init_result), 
                                            .init_value(x), 
                                            .load(load_result), 
                                            .in_value(res_in), 
                                            .out_value(result)
                                        );





	// …

endmodule