class adder_driver extends uvm_driver #(adder_item);
    `uvm_component_utils(adder_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual adder_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual adder_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual intereface adder_if");
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        adder_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.adder_cb)
            vif.adder_cb.a <= tr.a;
            vif.adder_cb.b <= tr.b;

            @(vif.adder_cb)
            seq_item_port.item_done();
        end

    endtask : run_phase

endclass : adder_driver