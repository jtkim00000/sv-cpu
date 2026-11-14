package reg_file_tb_pkg;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "reg_file_item.svh"
    `include "reg_file_sequence.svh"
    `include "reg_file_sequencer.svh"
    `include "reg_file_driver.svh"
    `include "reg_file_monitor.svh"
    `include "reg_file_coverage.svh"
    `include "reg_file_agent.svh"
    `include "reg_file_scoreboard.svh"
    `include "reg_file_env.svh"
    `include "reg_file_test.svh"

endpackage : reg_file_tb_pkg