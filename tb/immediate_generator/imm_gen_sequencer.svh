class imm_gen_sequencer extends uvm_sequencer #(imm_gen_item);
    `uvm_component_utils(imm_gen_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : imm_gen_sequencer