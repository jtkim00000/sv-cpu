class reg_file_sequencer extends uvm_sequencer #(reg_file_item);
    `uvm_component_utils(reg_file_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : reg_file_sequencer