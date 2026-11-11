package adder_tb_pkg;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "adder_item.svh"
    `include "adder_sequence.svh"
    `include "adder_sequencer.svh"
    `include "adder_driver.svh"
    `include "adder_monitor.svh"
    `include "adder_coverage.svh"
    `include "adder_agent.svh"
    `include "adder_scoreboard.svh"
    `include "adder_env.svh"
    `include "adder_test.svh"

endpackage : adder_tb_pkg