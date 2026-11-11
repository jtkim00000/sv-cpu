module mul_tb_top;

    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import mul_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    mul_if mul_if0 (clk);
    mul dut0 (mul_if0.DUT);

    initial begin
        mul_if0.rs1 = 32'd0;
        mul_if0.rs2 = 32'd0;
        mul_if0.sel = 3'd0;

        uvm_config_db#(virtual mul_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", mul_if0);

        uvm_config_db#(virtual mul_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", mul_if0);

        run_test("mul_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : mul_tb_top