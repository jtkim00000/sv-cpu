interface alu_if(input bit clk);

    logic [31:0] a, b, s;
    logic [3:0] sel;

    clocking alu_cb @(negedge clk);
        default output #0;
        output a, b, sel;
    endclocking

    clocking alu_cbm @(posedge clk);
        default input #1step;
        input a, b, sel, s;
    endclocking

    modport TEST    (clocking alu_cb);
    modport MONITOR (clocking alu_cbm);

    modport DUT (
        input a, b, sel,
        output s
    );

endinterface : alu_if