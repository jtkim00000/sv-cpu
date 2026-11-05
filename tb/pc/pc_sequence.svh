class pc_sequence extends uvm_sequence #(pc_item);
    `uvm_object_utils(pc_sequence)

    function new(string name)
        super.new(name);
    endfunction : new

    virtual task body();
        repeat (5) begin
            req = pc_item::type_id::create("req");
            start_item(req);
            assert(req.randomize());
            finish_item(req);
        end
    endtask : body

endclass : pc_sequence