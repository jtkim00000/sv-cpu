interface mul_if;
    import mul_pkg::*;

    mul_op_t sel;

    logic [31:0] rs1, rs2, data_out;
    logic [2:0] sel;

    modport TEST (
        input data_out,
        output sel, rs1, rs2
    );

    modport DUT (
        input sel, rs1, rs2,
        output data_out
    );

    modport MONITOR (
        input sel, rs1, rs2, data_out
    );

endinterface : mul_if