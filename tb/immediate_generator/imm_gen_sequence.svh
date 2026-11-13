class imm_gen_sequence extends uvm_sequence #(imm_gen_item);
    `uvm_object_utils(imm_gen_sequence)

    function new(string name = "imm_gen_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        req = imm_gen_item::type_id::create("req");
        repeat (50) begin
            start_item(req);
            if(!req.randomize())
                `uvm_fatal("IMM_GEN_RAND", "Could not randomize this imm_gen item")
            finish_item(req);
        end
    endtask : body

endclass : imm_gen_sequence