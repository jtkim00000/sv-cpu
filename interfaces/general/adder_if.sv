interface adder_if(input bit clk);

    logic [31:0] a, b, s;

    clocking adder_cb @(negedge clk);
        default output #0;
        output a, b;
    endclocking

    clocking adder_cbm @(posedge clk);
        default input #1step;
        input a, b, s;
    endclocking

    modport TEST (clocking adder_cb);

    modport DUT (
        input a, b,
        output s
    );

    modport MONITOR (clocking adder_cbm);

endinterface : adder_if