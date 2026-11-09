class pc_driver extends uvm_driver #(pc_item);
    `uvm_component_utils(pc_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual pc_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual pc_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface pc_if")
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        pc_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.pc_cb);
            vif.pc_cb.reset <= tr.reset;
            vif.pc_cb.write_data <= tr.write_data;

            @(vif.pc_cb);

            seq_item_port.item_done();

        end
        
    endtask : run_phase

endclass : pc_driver