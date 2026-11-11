class adder_sequence extends uvm_sequence #(adder_item);
    `uvm_object_utils(adder_sequence)

    function new(string name = "adder_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        req = adder_item::type_id::create("req");
        repeat (60) begin
            start_item(req);
            if(!req.randomize())
                `uvm_fatal("ADDER_RAND", "Could not randomize this adder item")
            finish_item(req);
        end
    endtask : body

endclass : adder_sequence