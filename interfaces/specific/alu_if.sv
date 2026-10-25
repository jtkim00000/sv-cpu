interface alu_if;

    logic [31:0] a, b, s;
    logic [3:0] sel;

    modport TEST (
        input s,
        output a, b, sel
    );

    modport DUT (
        input a, b, sel,
        output s
    );

    modport MONITOR (
        input a, b, s, sel
    );

endinterface : alu_if