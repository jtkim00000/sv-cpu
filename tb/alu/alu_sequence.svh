class alu_sequence extends uvm_sequence #(alu_item);
    `uvm_component_utils(alu_sequence)

    function new(string name = "alu_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        repeat (60) begin
            req = alu_item::type_id::create("req", this);
            start_item(req)
            if(!req.randomize())
                `uvm_fatal("ALU_RAND", "Could not randomize this alu item")
            finish_item(req)
        end
    endtask : body

endclass : alu_sequence