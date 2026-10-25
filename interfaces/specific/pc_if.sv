interface pc_if(input bit clk);

    logic [31:0] rdata, wdata;
    logic reset;

    clocking pc_cb @(posedge clk);
        input rdata;
        output wdata, reset;
    endclocking : pc_cb

    modport TEST (clocking pc_cb);

    modport DUT (
        input clk, reset, wdata,
        output rdata
    );

    clocking pc_cbm @(posedge clk);
        input rdata, wdata, reset;
    endclocking : pc_cmb

    modport MONITOR (clocking pc_cbm);

endinterface : pc_if