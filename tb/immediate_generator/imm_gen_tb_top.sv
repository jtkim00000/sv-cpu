module imm_gen_tb_top;

    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import imm_gen_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    immediate_generator_if imm_gen_if0 (clk);
    immediate_generator dut0 (imm_gen_if0.DUT);

    initial begin
        imm_gen_if0.instruction = 32'd0;

        uvm_config_db#(virtual immediate_generator_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", imm_gen_if0);

        uvm_config_db#(virtual immediate_generator_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", imm_gen_if0);

        run_test("imm_gen_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : imm_gen_tb_top