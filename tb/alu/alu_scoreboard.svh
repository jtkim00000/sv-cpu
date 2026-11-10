class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(alu_item, alu_scoreboard) ap_imp;

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

    function automatic logic [31:0] predict_sub(
        logic [31:0] a, b
    );
        return a - b;
    endfunction

    function automatic logic [31:0] predict_xor(
        logic [31:0] a, b
    );
        return a ^ b;
    endfunction

    function automatic logic [31:0] predict_or(
        logic [31:0] a, b
    );
        return a | b;
    endfunction

    function automatic logic [31:0] predict_and(
        logic [31:0] a, b
    );
        return a & b;
    endfunction

    function automatic logic [31:0] predict_sll(
        logic [31:0] a, b
    );
        return a << b[4:0];
    endfunction

    function automatic logic [31:0] predict_srl(
        logic [31:0] a, b
    );
        return a >> b[4:0];
    endfunction

    function automatic logic [31:0] predict_sra(
        logic [31:0] a, b
    );
        return $signed(a) >> b[4:0];
    endfunction

    function automatic logic [31:0] predict_slt(
        logic [31:0] a, b
    );
        logic lsb;

        if(a[31] != b[31])
            lsb = a[31];
        else 
            lsb = (a < b);


        return {31'd0, lsb};
    endfunction

    function automatic logic [31:0] predict_sltu(
        logic [31:0] a, b
    );
        return {31'd0, (a < b)};
    endfunction

    function automatic logic [31:0] predict_beq(
        logic [31:0] a, b
    );
        return {31'd0, (a == b)};
    endfunction

    function automatic logic [31:0] predict_bne(
        logic [31:0] a, b
    );
        return {31'd0, (a != b)};
    endfunction

    function automatic logic [31:0] predict_blt(
        logic [31:0] a, b
    );
        logic lsb;

        if(a[31] != b[31])
            lsb = a[31];
        else 
            lsb = (a < b);

        return {31'd0, lsb};
    endfunction

    function automatic logic [31:0] predict_bge(
        logic [31:0] a, b
    );
        logic lsb;

        if(a[31] != b[31])
            lsb = b[31];
        else 
            lsb = (a >= b);

        return {31'd0, lsb};
    endfunction

    function automatic logic [31:0] predict_bltu(
        logic [31:0] a, b
    );
        return {31'd0, (a < b)};
    endfunction

    function automatic logic [31:0] predict_bgeu(
        logic [31:0] a, b
    );
        return {31'd0, (a >= b)};
    endfunction

    virtual function void write(alu_item tr);
        ++check_count;

        case(tr.sel) 
            ALU_ADD:  expected_data = predict_add(tr.a, tr.b);
            ALU_SUB:  expected_data = predict_sub(tr.a, tr.b);
            ALU_XOR:  expected_data = predict_xor(tr.a, tr.b);
            ALU_OR:   expected_data = predict_or(tr.a, tr.b);
            ALU_AND:  expected_data = predict_and(tr.a, tr.b);
            ALU_SLL:  expected_data = predict_sll(tr.a, tr.b);
            ALU_SRL:  expected_data = predict_srl(tr.a, tr.b);
            ALU_SRA:  expected_data = predict_sra(tr.a, tr.b);
            ALU_SLT:  expected_data = predict_slt(tr.a, tr.b);
            ALU_SLTU: expected_data = predict_sltu(tr.a, tr.b);
            BR_EQ:    expected_data = predict_beq(tr.a, tr.b);
            BR_NE:    expected_data = predict_bne(tr.a, tr.b);
            BR_LT:    expected_data = predict_blt(tr.a, tr.b);
            BR_GE:    expected_data = predict_bge(tr.a, tr.b);
            BR_LTU:   expected_data = predict_bltu(tr.a, tr.b);
            BR_GEU:   expected_data = predict_bgeu(tr.a, tr.b);
            default:  expected_data = 32'd0;
        endcase

        if(tr.s !== expected_data) begin
            ++mismatch_count;
            `uvm_error("ALU MISMATCH", $sformatf("Doing sel=%08h, Expected s=%08h, got %08h", tr.sel, expected_data, tr.s))
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