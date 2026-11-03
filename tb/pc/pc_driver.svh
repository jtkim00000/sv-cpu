class pc_driver extends uvm_driver #(pc_item);
    `uvm_component_utils(pc_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual pc_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual pc_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Didn't get handle to virtual interface pc_if")
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        pc_item tr;

        forever begin
            seq_item_port.get_next_item(tr);

            @(posedge vif.clk);
            vif.reset <= tr.reset;
            vif.write_data <= tr.write_data;
            @(posedge vif.clk);

            vif.reset <= 0;

            @(posedge vif.clk);

            tr.read_data = vif.read_data;

            seq_item_port.item_done();

        end
        
    endtask : run_phase

endclass : pc_driver