class reg_file_sequence extends uvm_sequence #(reg_file_item);
    `uvm_object_utils(reg_file_sequence)

    function new(string name = "reg_file_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        repeat (50) begin
            req = reg_file_item::type_id::create("req");
            start_item(req);
            if (!req.randomize())
                `uvm_fatal("REG_FILE_RAND", "Could not randomize reg_file item")
            finish_item(req);
        end
    endtask : body

endclass : reg_file_sequence