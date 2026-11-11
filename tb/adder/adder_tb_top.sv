module adder_tb_top;

    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import adder_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    adder_if adder_if0 (clk);
    adder dut0 (adder_if0.DUT);

    initial begin
        adder_if0.a = 32'd0;
        adder_if0.b = 32'd0;

        uvm_config_db#(virtual adder_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", adder_if0);

        uvm_config_db#(virtual adder_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", adder_if0);

        run_test("adder_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : adder_tb_top