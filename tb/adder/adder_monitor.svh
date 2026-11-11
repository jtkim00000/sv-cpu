class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual adder_if.MONITOR vif;

    uvm_analysis_port #(adder_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual adder_if.MONITOR)::get(this, "", "vif", vif))
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface adder_if");
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        adder_item tr;

        if(vif == null)
            return;

        forever begin
            @(vif.adder_cbm);

            tr = adder_item::type_id::create("tr", this);

            tr.a = vif.adder_cbm.a;
            tr.b = vif.adder_cbm.b;
            tr.s = vif.adder_cbm.s;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : adder_monitor