module alu_tb_top;

    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import alu_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    alu_if alu_if0 (clk);
    alu dut0 (alu_if0.DUT);

    initial begin
        alu_if0.a = 32'd0;
        alu_if0.b = 32'd0;
        alu_if0.sel = 4'd0;

        uvm_config_db#(virtual alu_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", alu_if0);

        uvm_config_db#(virtual alu_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", alu_if0);

        run_test("alu_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : alu_tb_top