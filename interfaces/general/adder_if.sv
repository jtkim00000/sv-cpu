interface adder_if;

    logic [31:0] a, b, s;

    modport TEST (
        input s,
        output a, b
    );

    modport DUT (
        input a, b,
        output s
    );

    modport MONITOR (
        input a, b, s
    );

endinterface : adder_if