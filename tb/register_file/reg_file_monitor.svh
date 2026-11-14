class reg_file_monitor extends uvm_monitor;
    `uvm_component_utils(reg_file_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual register_file_if.MONITOR vif;

    uvm_analysis_port #(reg_file_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual register_file_if.MONITOR)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface reg_file_if")
        end
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        reg_file_item tr;

        if(vif == null)
            return;

        forever begin
            @(vif.register_file_cbm);

            tr = reg_file_item::type_id::create("tr", this);

            tr.write_enable = vif.register_file_cbm.write_enable;
            tr.rs1_addr = vif.register_file_cbm.rs1_addr;
            tr.rs2_addr = vif.register_file_cbm.rs2_addr;
            tr.write_addr = vif.register_file_cbm.write_addr;
            tr.write_data = vif.register_file_cbm.write_data;
            tr.rs1 = vif.register_file_cbm.rs1;
            tr.rs2 = vif.register_file_cbm.rs2;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : reg_file_monitor