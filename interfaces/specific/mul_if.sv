interface mul_if (input bit clk);
    import mul_pkg::*;

    logic [2:0] sel;
    logic [31:0] rs1, rs2, data_out;

    clocking mul_cb @(negedge clk);
        default output #0;
        output rs1, rs2, sel;
    endclocking : mul_cb

    clocking mul_cbm @(posedge clk);
        default input #1step;
        input rs1, rs2, sel, data_out;
    endclocking : mul_cbm

    modport TEST (clocking mul_cb);

    modport DUT (
        input sel, rs1, rs2,
        output data_out
    );

    modport MONITOR (clocking mul_cbm);

endinterface : mul_if