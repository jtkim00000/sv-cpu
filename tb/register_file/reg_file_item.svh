class reg_file_item extends uvm_sequence_item;

    rand bit write_enable;
    randc bit [31:0] rs1_addr, rs2_addr, write_addr, 
    rand bit [31:0] write_data;
    logic [31:0] rs1, rs2;

    constraint file_access_c {
        rs1_addr < 32'd32;
        rs2_addr < 32'd32;
        write_addr < 32'd32;
    }

    `uvm_object_utils_begin(reg_file_item)
        `uvm_field_int(write_enable, UVM_ALL_ON)
        `uvm_field_int(rs1_addr, UVM_ALL_ON)
        `uvm_field_int(rs2_addr, UVM_ALL_ON)
        `uvm_field_int(write_addr, UVM_ALL_ON)
        `uvm_field_int(write_data, UVM_ALL_ON)
        `uvm_field_int(rs1, UVM_ALL_ON)
        `uvm_field_int(rs2, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "reg_file_item");
        super.new(name);
    endfunction

endclass : reg_file_item