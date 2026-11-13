class pc_sequencer extends uvm_sequencer #(pc_item);
    `uvm_component_utils(pc_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : pc_sequencer