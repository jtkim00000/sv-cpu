class reg_file_driver extends uvm_driver #(reg_file_item);
    `uvm_component_utils(reg_file_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual register_file_if.TEST vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual register_file_if.TEST)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface reg_file_if")
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        reg_file_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(vif.reg_file_cb);
            vif.register_file_cb.write_enable <= tr.write_enable;
            vif.register_file_cb.rs1_addr <= tr.rs1_addr;
            vif.register_file_cb.rs2_addr <= tr.rs2_addr;
            vif.register_file_cb.write_addr <= tr.write_addr;
            vif.register_file_cb.write_data <= tr.write_data;

            @(vif.reg_file_cb);

            seq_item_port.item_done();

        end
        
    endtask : run_phase

endclass : reg_file_driver