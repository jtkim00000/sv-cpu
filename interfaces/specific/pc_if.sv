interface pc_if(input bit clk);

    logic [31:0] read_data, write_data;
    logic reset;

    clocking pc_cb @(posedge clk);
        default input #1step output #0;
        input read_data;
        output write_data, reset;
    endclocking : pc_cb

    modport TEST (clocking pc_cb);

    modport DUT (
        input clk, reset, write_data,
        output read_data
    );

    clocking pc_cbm @(posedge clk);
        default input #1step;
        input read_data, write_data, reset;
    endclocking : pc_cbm

    modport MONITOR (clocking pc_cbm);

endinterface : pc_if