class imm_gen_coverage extends uvm_subscriber #(imm_gen_item);
    `uvm_component_utils(imm_gen_coverage)

    covergroup cg_imm_gen_transaction with function sample(
        bit [31:0] instruction,
        logic [31:0] immediate
    );
        // No coverage bins needed
    endgroup : cg_imm_gen_transaction

    imm_gen_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_imm_gen_transaction = new();
    endfunction : new

    virtual function void write(imm_gen_item t);
        cg_imm_gen_transaction.sample(t.instruction, t.immediate);
    endfunction : write
endclass : imm_gen_coverage