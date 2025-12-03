module constraint_random_tb;

  localparam bit [31:0] RD_BASE = 32'h0000_0000;
  localparam bit [31:0] RD_END  = 32'h0000_FFFF;
  localparam bit [31:0] WR_BASE = 32'h1000_0000;
  localparam bit [31:0] WR_END  = 32'h1000_FFFF;


  logic clk;
  logic rst_n;

  logic        read_en;
  logic        write_en_vld;
  logic [3:0]  write_en;
  logic [31:0] addr;
  logic [31:0] wdata;
  logic        ready;
  logic [31:0] rdata;
  logic        rvalid;

  byte read_win [0:65535];
  byte write_win[0:65535];


  logic        rvalid_q;
  logic [31:0] rdata_q;


  int N;
  int k;

  typedef enum logic {OP_READ, OP_WRITE} op_e;

  typedef struct {
    op_e        op;
    bit [31:0]  addr;
    int unsigned burst_len;
    bit [3:0]   write_en;
  } mem_txn_s;


  function automatic bit in_range(input bit [31:0] a, input bit [31:0] lo, input bit [31:0] hi);
    return (a >= lo) && (a <= hi);
  endfunction

  function automatic int unsigned rd_off(input bit [31:0] a);
    return int'(a - RD_BASE);
  endfunction

  function automatic int unsigned wr_off(input bit [31:0] a);
    return int'(a - WR_BASE);
  endfunction

  function automatic bit we_legal(input bit [3:0] we);
    return (we == 4'b1111) ||
           (we == 4'b1100) || (we == 4'b0011) ||
           (we == 4'b1000) || (we == 4'b0100) ||
           (we == 4'b0010) || (we == 4'b0001);
  endfunction


  function automatic bit [31:0] do_read(input bit [31:0] a);
    bit [31:0] rd;
    int unsigned o; 
    rd = '0;
    if (in_range(a, RD_BASE, RD_END)) begin
      o = rd_off(a);
      rd[7:0]   = read_win[o+0];
      rd[15:8]  = read_win[o+1];
      rd[23:16] = read_win[o+2];
      rd[31:24] = read_win[o+3];
    end
    return rd;
  endfunction


  task automatic do_write(input bit [31:0] a, input bit [3:0] be, input bit [31:0] wd);
    int unsigned o; 
    if (!in_range(a, WR_BASE, WR_END)) return;
    o = wr_off(a);
    if (be[0]) write_win[o+0] = wd[7:0];
    if (be[1]) write_win[o+1] = wd[15:8];
    if (be[2]) write_win[o+2] = wd[23:16];
    if (be[3]) write_win[o+3] = wd[31:24];
  endtask


  task automatic gen_txn(output mem_txn_s t);
    int unsigned len;
    bit [31:0]   base_lo, base_hi, max_start, raw_addr;
    int          r100;
    bit [3:0]    we_list [0:6]; 
    int          idx;


    len = $urandom_range(2, 8);
    t.burst_len = len;


    r100 = $urandom_range(0,99);
    t.op = (r100 < 80) ? OP_READ : OP_WRITE;


    if (t.op == OP_READ) begin
      base_lo = RD_BASE;
      base_hi = RD_END;
      t.write_en = 4'b0000;
    end else begin
      base_lo = WR_BASE;
      base_hi = WR_END;

      we_list[0]=4'b1111; we_list[1]=4'b1100; we_list[2]=4'b0011;
      we_list[3]=4'b1000; we_list[4]=4'b0100; we_list[5]=4'b0010; we_list[6]=4'b0001;
      idx = $urandom_range(0,6);
      t.write_en = we_list[idx];
    end


    max_start = base_hi - (4*(len-1));


    raw_addr   = $urandom_range(base_lo, max_start);
    t.addr     = {raw_addr[31:2], 2'b00};


  endtask


  task automatic drive_one_txn(input mem_txn_s t);
    int unsigned i;
    bit [31:0] a;
    a = t.addr;

    for (i = 0; i < t.burst_len; i++) begin
      @(posedge clk);
      while (!ready) @(posedge clk);

      addr <= a;

      if (t.op == OP_READ) begin
        read_en      <= 1'b1;
        write_en_vld <= 1'b0;
        write_en     <= 4'b0000;
        wdata        <= '0;
      end else begin
        read_en      <= 1'b0;
        write_en_vld <= 1'b1;
        write_en     <= t.write_en;
        wdata        <= $urandom();
      end

      a += 32'd4;
    end

    @(posedge clk);
    read_en      <= 1'b0;
    write_en_vld <= 1'b0;
    write_en     <= 4'b0000;
    addr         <= '0;
    wdata        <= '0;
  endtask


  assign ready  = 1'b1;    
  assign rvalid = rvalid_q;
  assign rdata  = rdata_q;


  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 1'b0;
    read_en      = 1'b0;
    write_en_vld = 1'b0;
    write_en     = 4'b0000;
    addr         = '0;
    wdata        = '0;
    foreach (read_win[i])  read_win[i]  = byte'(i & 8'hFF); 
    foreach (write_win[i]) write_win[i] = 8'h00;
    repeat (3) @(posedge clk);
    rst_n = 1'b1;
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rvalid_q <= 1'b0;
      rdata_q  <= '0;
    end else begin
      rvalid_q <= 1'b0;
      if (write_en_vld) do_write(addr, write_en, wdata);
      if (read_en) begin
        rdata_q  <= do_read(addr);
        rvalid_q <= 1'b1;
      end
    end
  end


  property p_no_rw_same_cycle;
    @(posedge clk) disable iff (!rst_n)
      !(read_en && write_en_vld);
  endproperty
  assert property (p_no_rw_same_cycle) else $error("read_en && write_en_vld both 1!");

  property p_we_rule;
    @(posedge clk) disable iff (!rst_n)
      (read_en) |-> (write_en == 4'b0000) and
      (write_en_vld) |-> we_legal(write_en);
  endproperty
  assert property (p_we_rule) else $error("write_en rule violated!");

  property p_addr_align;
    @(posedge clk) disable iff (!rst_n)
      (read_en || write_en_vld) |-> (addr[1:0] == 2'b00);
  endproperty
  assert property (p_addr_align) else $error("addr not 4B aligned!");

  property p_region_check;
    @(posedge clk) disable iff (!rst_n)
      (read_en)      |-> in_range(addr, RD_BASE, RD_END) and
      (write_en_vld) |-> in_range(addr, WR_BASE, WR_END);
  endproperty
  assert property (p_region_check) else $error("address region mismatch!");


  always_ff @(posedge clk) begin
    if (rvalid) $display("[%0t] RVALID  rdata=0x%08h", $time, rdata);
  end


  initial begin
    mem_txn_s t;
    wait (rst_n);

    N = 12;
    for (k = 0; k < N; k++) begin
      gen_txn(t);
      $display("[%0t] TXN%0d: %s  addr=0x%08h  len=%0d  we=0b%b",
               $time, k, (t.op==OP_READ)?"READ":"WRITE", t.addr, t.burst_len, t.write_en);
      drive_one_txn(t);
      repeat ($urandom_range(0,3)) @(posedge clk);
    end

    repeat (10) @(posedge clk);
    $display("=== TEST DONE ===");
    $finish;
  end

  
endmodule


