module pc_tb_top;

    import uvm_pkg::*;
    import pc_tb_pkg::*;
    `include "uvm_macros.svh"

    bit clk;
    always #10 clk = ~clk;

    pc_if pc_if0 (clk);
    pc dut0 (pc_if0.TEST);

    initial begin
        uvm_config_db #(virtual pc_if)::set(null, "uvm_test_top.*", "vif", pc_if0);
        run_test("pc_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : pc_tb_top