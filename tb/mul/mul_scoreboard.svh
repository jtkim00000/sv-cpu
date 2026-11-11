class mul_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(mul_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    uvm_analysis_imp #(mul_item, mul_scoreboard) ap_imp;

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

    function automatic logic [31:0] predict_mull(
        logic [31:0] a, b
    );
        logic [63:0] result;

        result = a * b;

        return result[31:0];
    endfunction

    function automatic logic [31:0] predict_mul_high(
        logic [31:0] a,
        logic [31:0] b,
        bit          a_is_signed,
        bit          b_is_signed
    );
        logic signed [32:0] a_ext;
        logic signed [32:0] b_ext;
        logic signed [65:0] product;

        a_ext = a_is_signed ? {a[31], a} : {1'b0, a};
        b_ext = b_is_signed ? {b[31], b} : {1'b0, b};

        product = a_ext * b_ext;

        return product[63:32];
    endfunction

    function automatic logic [31:0] predict_div(
        logic [31:0] a, b
    );
        if(b == 32'd0)
            return 32'hFFFFFFFF;
        else if((32'h80000000) && (b == 32'hFFFFFFFF))
            return 32'h80000000;

        return ($signed(a) / $signed(b));
    endfunction

    function automatic logic [31:0] predict_divu(
        logic [31:0] a, b
    );
        if(b == 32'd0)
            return 32'hFFFFFFFF;

        return (a / b);
    endfunction

    function automatic logic [31:0] predict_rem(
        logic [31:0] a, b
    );
        if(b == 32'd0)
            return a;
        else if((32'h80000000) && (b == 32'hFFFFFFFF))
            return 32'd0;

        return ($signed(a) % $signed(b));
    endfunction

    function automatic logic [31:0] predict_remu(
        logic [31:0] a, b
    );
        if(b == 32'd0)
            return a;

        return (a % b);
    endfunction

    virtual function void write(mul_item tr);
        ++check_count;

        case(tr.sel) 
            MUL_L:    expected_data = predict_mull(tr.rs1, tr.rs2);
            MUL_H:   expected_data = predict_mul_high(tr.rs1, tr.rs2, 1, 1);
            MUL_HU:  expected_data = predict_mul_high(tr.rs1, tr.rs2, 0, 0);
            MUL_HSU: expected_data = predict_mul_high(tr.rs1, tr.rs2, 1, 0);
            DIV:      expected_data = predict_div(tr.rs1, tr.rs2);
            DIV_U:    expected_data = predict_divu(tr.rs1, tr.rs2);
            REM:      expected_data = predict_rem(tr.rs1, tr.rs2);
            REM_U:    expected_data = predict_remu(tr.rs1, tr.rs2);
            default:  expected_data = 32'd0;
        endcase

        if(tr.data_out !== expected_data) begin
            ++mismatch_count;
            `uvm_error("MUL MISMATCH", $sformatf("Doing sel=%08h, Expected s=%08h, got %08h", tr.sel, expected_data, tr.data_out))
        end
    endfunction : write

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        `uvm_info(
            "MUL_SUMMARY", 
            $sformatf("Checks: %0d, mismatches: %0d",check_count, mismatch_count),
            UVM_LOW
            )

        if (check_count == 0)
            `uvm_error("MUL_NO_CHECKS", "No MUL results were checked")
    endfunction : report_phase

endclass : mul_scoreboard