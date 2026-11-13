class imm_gen_item extends uvm_sequence_item;
    
    rand bit [31:0] instruction;
    randc bit [6:0] opcode;
    logic [31:0] immediate;

    constraint instr_opcode_c {
        opcode inside {
            7'b0010011,
            7'b0000011,
            7'b1100111,
            7'b1110011,
            7'b0100011,
            7'b1100011,
            7'b0110111,
            7'b0010111,
            7'b1101111,
            7'b0000000
        };
    }

    constraint instr_c {
        instruction[6:0] == opcode;
    }

    `uvm_object_utils_begin(imm_gen_item)
        `uvm_field_int(instruction, UVM_ALL_ON)
        `uvm_field_int(opcode, UVM_ALL_ON)
        `uvm_field_int(immediate, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "imm_gen_item");
        super.new(name);
    endfunction : new

endclass : imm_gen_item