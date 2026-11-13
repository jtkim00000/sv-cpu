interface immediate_generator_if (input bit clk);
    logic [31:0] instruction, immediate;

    clocking imm_gen_cb @(negedge clk);
        default output #0;
        output instruction;
    endclocking : imm_gen_cb

    clocking imm_gen_cbm @(posedge clk);
        default output #1step;
        input instruction, immediate;
    endclocking : imm_gen_cbm

    modport TEST (clocking imm_gen_cb);

    modport DUT (input instruction, output immediate);

    modport MONITOR (clocking imm_gen_cbm);

endinterface : immediate_generator_if