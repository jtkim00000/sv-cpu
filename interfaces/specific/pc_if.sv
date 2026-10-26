interface pc_if(input bit clk);

    logic [31:0] read_data, write_data;
    logic reset;

    clocking pc_cb @(posedge clk);
        input read_data;
        output write_data, reset;
    endclocking : pc_cb

    modport TEST (clocking pc_cb);

    modport DUT (
        input clk, reset, write_data,
        output read_data
    );

    clocking pc_cbm @(posedge clk);
        input read_data, write_data, reset;
    endclocking : pc_cmb

    modport MONITOR (clocking pc_cbm);

endinterface : pc_if