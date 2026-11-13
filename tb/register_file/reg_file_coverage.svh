class pc_coverage extends uvm_subscriber #(pc_item);
    `uvm_component_utils(pc_coverage)

    covergroup cg_pc_transaction with function sample(
        bit          reset,
        bit   [31:0] write_data,
        logic [31:0] read_data
    );
        option.per_instance = 1;

        cp_reset: coverpoint reset {
            bins load_cycle  = {0};
            bins reset_cycle = {1};
        }

        cp_load_data: coverpoint write_data iff (!reset) {
            bins zero      = {32'h0000_0000};
            bins high_bit  = {32'h8000_0000};
            bins all_ones  = {32'hFFFF_FFFF};
        }

        cp_load_low_bits: coverpoint write_data[1:0] iff (!reset) {
            bins patterns[] = {[0:3]};
        }

        cp_reset_priority: coverpoint
            ((read_data != 32'd0) && (write_data != 32'd0))
            iff (reset && !$isunknown(read_data)) {
                bins reset_nonzero_state_and_input = {1};
            }
    endgroup : cg_pc_transaction

    pc_item trans;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_pc_transaction = new();
    endfunction : new

    virtual function void write(pc_item t);
        cg_pc_transaction.sample(t.reset, t.write_data, t.read_data);
    endfunction : write
endclass : pc_coverage