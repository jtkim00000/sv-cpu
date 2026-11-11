class mul_sequencer extends uvm_sequencer #(mul_item);
    `uvm_component_utils(mul_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : mul_sequencer