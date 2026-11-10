class pc_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(pc_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(pc_item, pc_scoreboard) ap_imp;

    logic [31:0] expected_data;
    bit          expected_valid = 0;
    int unsigned check_count = 0;
    int unsigned mismatch_count = 0;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);
    endfunction : build_phase

    virtual function void write(pc_item tr);
        if (expected_valid) begin
            ++check_count;

            if (tr.read_data !== expected_data) begin
                ++mismatch_count;
                `uvm_error("PC_MISMATCH", $sformatf("Expected read_data=%08h, got %08h", expected_data, tr.read_data))
            end
        end

        expected_data = tr.reset ? 32'd0 : tr.write_data;
        expected_valid = 1;
    endfunction : write

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "PC_SUMMARY", 
            $sformatf("Checks: %0d, mismatches: %0d",check_count, mismatch_count),
            UVM_LOW
            )

        if (check_count == 0)
            `uvm_error("PC_NO_CHECKS", "No PC results were checked")
    endfunction : report_phase

endclass : pc_scoreboard