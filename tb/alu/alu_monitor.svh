class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual alu_if.MONITOR vif;

    uvm_analysis_port #(alu_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual alu_if.MONITOR)::get(this, "", "vif", vif))
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface alu_if");
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        alu_item tr;

        if(vif == null)
            return;

        forever begin
            @(vif.alu_cbm);

            tr = alu_item::type_id::create("tr", this);

            tr.a = vif.alu_cbm.a;
            tr.b = vif.alu_cbm.b;
            tr.sel = vif.alu_cbm.sel;
            tr.s = vif.alu_cbm.s;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : alu_monitor