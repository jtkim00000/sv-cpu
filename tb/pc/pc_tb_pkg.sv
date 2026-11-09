package pc_tb_pkg;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "pc_item.svh"
    `include "pc_sequence.svh"
    `include "pc_sequencer.svh"
    `include "pc_driver.svh"
    `include "pc_monitor.svh"
    `include "pc_coverage.svh"
    `include "pc_agent.svh"
    `include "pc_scoreboard.svh"
    `include "pc_env.svh"
    `include "pc_test.svh"

endpackage : pc_tb_pkg