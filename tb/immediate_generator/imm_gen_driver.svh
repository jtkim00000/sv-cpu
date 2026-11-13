class imm_gen_driver extends uvm_driver #(imm_gen_item);
    `uvm_component_utils(imm_gen_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual immediate_generator_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual immediate_generator_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual intereface imm_gen_if");
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        imm_gen_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.imm_gen_cb)
            vif.imm_gen_cb.instruction <= tr.instruction;

            @(vif.imm_gen_cb)
            seq_item_port.item_done();
        end

    endtask : run_phase

endclass : imm_gen_driver