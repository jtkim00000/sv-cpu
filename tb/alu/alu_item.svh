class alu_item extends uvm_sequence_item;
    
    rand bit [31:0] a, b;
    randc bit [3:0] sel;
    logic [31:0] s;

    constraint op_sel_c {
        sel <= 4'd15;
    }

    `uvm_object_utils_begin(alu_item)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(b, UVM_ALL_ON);
        `uvm_field_int(sel, UVM_ALL_ON);
        `uvm_field_int(s, UVM_ALL_ON);
    `uvm_object_utils_end

    function new(string name = "alu_item");
        super.new(name);
    endfunction : new

endclass : alu_item