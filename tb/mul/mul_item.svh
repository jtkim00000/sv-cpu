class mul_item extends uvm_sequence_item;
    
    rand bit [31:0] rs1, rs2;
    randc bit [2:0] sel;
    logic [31:0] data_out;

    `uvm_object_utils_begin(mul_item)
        `uvm_field_int(rs1, UVM_ALL_ON);
        `uvm_field_int(rs2, UVM_ALL_ON);
        `uvm_field_int(sel, UVM_ALL_ON);
        `uvm_field_int(data_out, UVM_ALL_ON);
    `uvm_object_utils_end

    function new(string name = "mul_item");
        super.new(name);
    endfunction : new

endclass : mul_item