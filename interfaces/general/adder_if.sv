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
        input a, b, c
    );

endinterface : adder_if