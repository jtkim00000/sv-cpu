class reg_file_coverage extends uvm_subscriber #(reg_file_item);
    `uvm_component_utils(reg_file_coverage)

    covergroup cg_reg_file_transaction with function sample(
        bit          write_enable,
        bit   [31:0] rs1_addr,
        bit   [31:0] rs2_addr,
        bit   [31:0] write_addr,
        bit   [31:0] write_data,
        logic [31:0] rs1,
        logic [31:0] rs2,
    );
        option.per_instance = 1;

        cp_write: coverpoint write_enable {
            bins non_write_cycle  = {0};
            bins write_cycle = {1};
        }

    endgroup : cg_reg_file_transaction

    reg_file_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_reg_file_transaction = new();
    endfunction : new

    virtual function void write(reg_file_item t);
        cg_reg_file_transaction.sample(t.write_enable, t.rs1_addr, t.rs2_addr, t.write_addr, t.write_data, t.rs1, t.rs2);
    endfunction : write
endclass : reg_file_coverage