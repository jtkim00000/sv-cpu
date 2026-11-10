class alu_sequence extends uvm_sequence #(alu_item);
    `uvm_object_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        req = alu_item::type_id::create("req");
        repeat (60) begin
            start_item(req);
            if(!req.randomize())
                `uvm_fatal("ALU_RAND", "Could not randomize this alu item")
            finish_item(req);
        end
    endtask : body

endclass : alu_sequence