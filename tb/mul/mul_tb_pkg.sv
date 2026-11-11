package mul_tb_pkg;
    timeunit 1ns; 
    timeprecision 1ps;
    
    import uvm_pkg::*;
    import mul_pkg::*;
    `include "uvm_macros.svh"

    `include "mul_item.svh"
    `include "mul_sequence.svh"
    `include "mul_sequencer.svh"
    `include "mul_driver.svh"
    `include "mul_monitor.svh"
    `include "mul_coverage.svh"
    `include "mul_agent.svh"
    `include "mul_scoreboard.svh"
    `include "mul_env.svh"
    `include "mul_test.svh"

endpackage : mul_tb_pkg