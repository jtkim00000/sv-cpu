class pc_item extends uvm_sequence_item;

    rand bit reset;
    rand bit [31:0] write_data;
    logic [31:0] read_data;

    constraint write_data_c {
        write_data[1:0] == 2'b00    // Align on a 4-byte boundary
    }

    `uvm_object_utils_begin(pc_item)
        `uvm_field_int(reset, UVM_ALL_ON)
        `uvm_field_int(write_data, UVM_ALL_ON)
        `uvm_field_int(read_data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "pc_item");
        super.new(name);
    endfunction

endclass : pc_item