class pc_coverage extends uvm_subscriber;
    `uvm_component_utils(pc_coverage)

    covergroup cg_pc_transaction;
        coverpoint trans.write_data;
        coverpoint trans.reset;
    endgroup : cg_pc_transaction

    pc_item trans;

    function new(string name, uvm_compoenent parent);
        super.new(name, parent);
        cg_pc_transaction = new();
    endfunction : new

    virtual function void write();
        trans = t;
        cg_pc_transaction.sample();
    endfunction : write
endclass : pc_coverage