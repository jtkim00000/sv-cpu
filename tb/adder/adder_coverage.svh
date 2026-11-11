class adder_coverage extends uvm_subscriber #(adder_item);
    `uvm_component_utils(adder_coverage)

    covergroup cg_adder_transaction with function sample(
        bit [31:0] a,
        bit [31:0] b,
        logic [31:0] s
    );
        // No coverage bins needed
    endgroup : cg_adder_transaction

    adder_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_adder_transaction = new();
    endfunction : new

    virtual function void write(adder_item t);
        cg_adder_transaction.sample(t.a, t.b, t.s);
    endfunction : write
endclass : adder_coverage