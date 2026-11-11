class mul_driver extends uvm_driver #(mul_item);
    `uvm_component_utils(mul_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual mul_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual mul_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual intereface mul_if");
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        mul_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.mul_cb)
            vif.mul_cb.rs1 <= tr.rs1;
            vif.mul_cb.rs2 <= tr.rs2;
            vif.mul_cb.sel <= tr.sel;

            @(vif.mul_cb)
            seq_item_port.item_done();
        end

    endtask : run_phase

endclass : mul_driver