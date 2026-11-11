interface adder_if(input bit clk);

    logic [31:0] a, b, s;

    clocking adder_cb @(negedge clk);
        default output #0;
        output a, b;
    endclocking : adder_cb

    clocking adder_cbm @(posedge clk);
        default input #1step;
        input a, b, s;
    endclocking : adder_cbm

    modport TEST (clocking adder_cb);

    modport DUT (
        input a, b,
        output s
    );

    modport MONITOR (clocking adder_cbm);

endinterface : adder_if