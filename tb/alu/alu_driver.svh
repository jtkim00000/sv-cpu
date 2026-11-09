class alu_driver extends uvm_driver;
    `uvm_component_utils(alu_driver)

    function new(string name, ucm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual alu_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual alu_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual intereface alu_if");
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        alu_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.alu_cb)
            vif.alu_cb.a <= tr.a;
            vif.alu_cb.a <= tr.a;
            vif.alu_cb.sel <= tr.sel;

            @(vif.alu_cb)
            seq_item_port.item_done();
        end

    endtask : run_phase

endclass : alu_driver