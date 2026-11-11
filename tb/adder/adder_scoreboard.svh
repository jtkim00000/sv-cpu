class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(adder_item, adder_scoreboard) ap_imp;

    logic [31:0] expected_data;
    bit          expected_valid;
    int unsigned check_count;
    int unsigned mismatch_count;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction : build_phase

    // ========================================
    // Scoreboard Helper Functions
    // ========================================

    function automatic logic [31:0] predict_add(
        logic [31:0] a, b
    );
        return a + b;
    endfunction

    virtual function void write(adder_item tr);
        ++check_count;
        
        expected_data = predict_add(tr.a, tr.b);

        if(tr.s !== expected_data) begin
            ++mismatch_count;
            `uvm_error("ADDER MISMATCH", $sformatf("Expected s=%08h, got %08h", expected_data, tr.s))
        end
    endfunction : write

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "ADDER_SUMMARY", 
            $sformatf("Checks: %0d, mismatches: %0d",check_count, mismatch_count),
            UVM_LOW
            )

        if (check_count == 0)
            `uvm_error("ADDER_NO_CHECKS", "No Adder results were checked")
    endfunction : report_phase

endclass : adder_scoreboard