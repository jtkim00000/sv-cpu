class adder_item extends uvm_sequence_item;
    
    rand bit [31:0] a, b;
    logic [31:0] s;

    `uvm_object_utils_begin(adder_item)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(b, UVM_ALL_ON);
        `uvm_field_int(s, UVM_ALL_ON);
    `uvm_object_utils_end

    function new(string name = "adder_item");
        super.new(name);
    endfunction : new

endclass : adder_item