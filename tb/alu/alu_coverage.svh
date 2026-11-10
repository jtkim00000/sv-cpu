class alu_coverage extends uvm_subscriber #(alu_item);
    `uvm_component_utils(alu_coverage)

    covergroup cg_alu_transaction with function sample(
        bit [31:0] a,
        bit [31:0] b,
        bit[3:0] sel,
        logic [31:0] s
    );
        option.per_instance = 1;

        cp_op: coverpoint sel {
            bins ops[] = {
                ALU_ADD, ALU_SUB, ALU_XOR, ALU_OR, ALU_AND,
                ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU,
                BR_EQ, BR_NE, BR_LT, BR_GE, BR_LTU, BR_GEU 
            };
        }

        cp_shift_op: coverpoint sel {
            bins shifts[] = {ALU_SLL, ALU_SRL, ALU_SRA};
        }

        cp_shift_amt: coverpoint b[4:0]
            iff (sel inside {ALU_SLL, ALU_SRL, ALU_SRA}) {
                bins zero   = {0};
                bins one    = {1};
                bins middle = {[2:30]};
                bins max    = {31};
            }

        cx_shift: cross cp_shift_op, cp_shift_amt;

        cp_compare_op: coverpoint sel {
            bins compares[] = {ALU_SLT, ALU_SLTU};
        }

        cp_compare_signs: coverpoint {a[31], b[31]} // concatenate
            iff (sel inside {ALU_SLT, ALU_SLTU}) {
                bins a_negative = {2'b10};
                bins b_negative = {2'b01};
            }

        cx_compare: cross cp_compare_op, cp_compare_signs;

    endgroup : cg_alu_transaction

    alu_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_alu_transaction = new();
    endfunction : new

    virtual function void write(alu_item t);
        cg_alu_transaction.sample(t.a, t.b, t.sel, t.s);
    endfunction : write
endclass : alu_coverage