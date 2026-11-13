class imm_gen_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(imm_gen_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(imm_gen_item, imm_gen_scoreboard) ap_imp;

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

    function automatic logic [31:0] predict_i_type(
        logic [31:0] instr
    );
        return {{21{instr[31]}}, instr[30:25], instr[24:21], instr[20]};
    endfunction

    function automatic logic [31:0] predict_s_type(
        logic [31:0] instr
    );
        return {{21{instr[31]}}, instr[30:25], instr[11:8], instr[7]};
    endfunction

    function automatic logic [31:0] predict_b_type(
        logic [31:0] instr
    );
        return {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    endfunction

    function automatic logic [31:0] predict_u_type(
        logic [31:0] instr
    );
        return {instr[31], instr[30:20], instr[19:12], {12{1'b0}}};
    endfunction

    function automatic logic [31:0] predict_j_type(
        logic [31:0] instr
    );
        return {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0};
    endfunction

    virtual function void write(imm_gen_item tr);
        ++check_count;

        case(tr.instruction[6:0])
            7'b0010011, 7'b0000011, 7'b1100111, 7'b1110011: expected_data = predict_i_type(tr.instruction);
            7'b0100011: expected_data = predict_s_type(tr.instruction);
            7'b1100011: expected_data = predict_b_type(tr.instruction);
            7'b0110111, 7'b0010111: expected_data = predict_u_type(tr.instruction);
            7'b1101111: expected_data = predict_j_type(tr.instruction);
            default: expected_data = 32'd0;
        endcase

        if(tr.immediate !== expected_data) begin
            ++mismatch_count;
            `uvm_error("IMM_GEN MISMATCH", $sformatf("Expected s=%08h, got %08h", expected_data, tr.immediate))
        end
    endfunction : write

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "IMM_GEN_SUMMARY", 
            $sformatf("Checks: %0d, mismatches: %0d",check_count, mismatch_count),
            UVM_LOW
            )

        if (check_count == 0)
            `uvm_error("ADDER_NO_CHECKS", "No Immediate Generator results were checked")
    endfunction : report_phase

endclass : imm_gen_scoreboard