class mul_coverage extends uvm_subscriber #(mul_item);
    `uvm_component_utils(mul_coverage)

    covergroup cg_mul_transaction with function sample(
        bit [31:0] rs1,
        bit [31:0] rs2,
        bit[2:0] sel,
        logic [31:0] data_out
    );
        option.per_instance = 1;

        cp_op: coverpoint sel {
            bins ops[] = {
                MUL_L, MUL_H, MUL_HU, 
                MUL_HSU, DIV, DIV_U, 
                REM, REM_U
            };
        }

        cp_div_nums: coverpoint rs2 
            iff (sel inside {DIV, DIV_U}) {
                bins rs2_negative = {[-2147483647:-1]};
                bins rs2_zero = {32'd0};
                bins rs2_non_zero = {[1:2147483647]};
            }
        
        cp_rem_nums: coverpoint rs2 
            iff (sel inside {REM, REM_U}) {
                bins rs2_negative = {[-2147483647:-1]};
                bins rs2_zero = {32'd0};
                bins rs2_non_zero = {[1:2147483647]};
            }

    endgroup : cg_mul_transaction

    mul_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_mul_transaction = new();
    endfunction : new

    virtual function void write(mul_item t);
        cg_mul_transaction.sample(t.rs1, t.rs2, t.sel, t.data_out);
    endfunction : write
endclass : mul_coverage