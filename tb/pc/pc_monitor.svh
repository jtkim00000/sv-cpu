class pc_monitor extends uvm_monitor;
    `uvm_component_utils(pc_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual pc_if.MONITOR vif;

    uvm_analysis_port #(pc_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual pc_if.MONITOR)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface pc_if")
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        pc_item tr;

        if(vif == null)
            return

        forever begin
            @(vif.pc_cbm);

            tr = pc_item::type_id::create("tr", this);

            tr.write_data = vif.write_data;
            tr.read_data = vif.read_data;
            tr.reset = vif.reset;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : pc_monitor