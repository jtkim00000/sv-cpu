class mul_sequence extends uvm_sequence #(mul_item);
    `uvm_object_utils(mul_sequence)

    function new(string name = "mul_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        req = mul_item::type_id::create("req");
        repeat (56) begin
            start_item(req);
            if(!req.randomize())
                `uvm_fatal("MUL_RAND", "Could not randomize this multiply item")
            finish_item(req);
        end
    endtask : body

endclass : mul_sequence