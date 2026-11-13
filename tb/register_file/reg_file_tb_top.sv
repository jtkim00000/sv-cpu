module pc_tb_top;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import pc_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    pc_if pc_if0 (clk);
    pc dut0 (pc_if0.DUT);

    initial begin
        pc_if0.reset      = 1'b1;
        pc_if0.write_data = 32'd0;

        uvm_config_db#(virtual pc_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", pc_if0);

        uvm_config_db#(virtual pc_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", pc_if0);

        run_test("pc_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : pc_tb_top