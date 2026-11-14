module reg_file_tb_top;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import reg_file_tb_pkg::*;

    bit clk;
    always #10ns clk = ~clk;

    register_file_if register_file_if0 (clk);
    register_file dut0 (reg_file_if0.DUT);

    initial begin
        reg_file_if0.reset      = 1'b1;
        reg_file_if0.write_data = 32'd0;

        uvm_config_db#(virtual register_file_if.TEST)::set(null, "uvm_test_top.m_top_env.m_agent.m_driver", "vif", reg_file_if0);

        uvm_config_db#(virtual register_file_if.MONITOR)::set(null, "uvm_test_top.m_top_env.m_agent.m_monitor", "vif", reg_file_if0);

        run_test("reg_file_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule : reg_file_tb_top