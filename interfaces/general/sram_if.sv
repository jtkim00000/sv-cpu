interface sram_if (input logic clk);

    logic write_enable, sz;
    logic [1:0] num_bytes;
    logic [31:0] addr, write_data, read_data;

    clocking sram_cb @(posedge clk);
        default input #1step output #0;
        input read_data;
        output write_enable, sz, num_bytes, addr, write_data;
    endclocking : sram_cb

    modport TEST (clocking sram_cb);
    
    modport DUT (
        input clk, write_enable, sz, num_bytes, addr, write_data,
        output read_data
    );

    clocking sram_cb_m @(posedge clk);
        default input #1step;
        input write_enable, sz, num_bytes, addr, write_data, read_data;
    endclocking : sram_cb_m

    modport MONITOR (clocking sram_cb_m);

endinterface : sram_if