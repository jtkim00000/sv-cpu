class alu_scoreboard extends uvm_scoreboard;
    'uvm_component_utils(alu_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(alu_item) ap_imp;

    logic [31:0] expected_data;
    bit          expected_valid;
    int unsigned check_count;
    int unsigned mismatch_count;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction : build_phase

    virtual function void write(alu_item tr);
        if(expected_valid) begin
            ++check_count;

        end
    endfunction : write

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "ALU_SUMMARY", 
            $sformatf("Checks: %0d, mismatches: %0d",check_count, mismatch_count),
            UVM_LOW
            )

        if (check_count == 0)
            `uvm_error("ALU_NO_CHECKS", "No ALU results were checked")
    endfunction : report_phase

endclass : alu_scoreboard