package alu_tb_pkg;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "alu_item.svh"
    `include "alu_sequence.svh"
    `include "alu_sequencer.svh"
    `include "alu_driver.svh"
    `include "alu_monitor.svh"
    `include "alu_coverage.svh"
    `include "alu_agent.svh"
    `include "alu_scoreboard.svh"
    `include "alu_env.svh"
    `include "alu_test.svh"

endpackage : alu_tb_pkg