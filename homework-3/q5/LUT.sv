module LUT (
	input  logic [2:0]  addr, 
	output logic [15:0] data);
	
	always_comb begin
        data = 16'h0000;
		
        case(addr)
			0: data = 16'h7FFF;//1
			1: data = 16'h1555;//1/2 * 1/3
			2: data = 16'h0666;//1/4 * 1/5
			3: data = 16'h030B;//1/6 * 1/7
			4: data = 16'h01C4;//1/8 * 1/9
			5: data = 16'h0126;//1/10 * 1/11
			6: data = 16'h00D1;//1/12 * 1/13
			7: data = 16'h009A;//1/14 * 1/15
		endcase
	end
	
endmodule