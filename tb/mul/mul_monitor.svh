class mul_monitor extends uvm_monitor;
    `uvm_component_utils(mul_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual mul_if.MONITOR vif;

    uvm_analysis_port #(mul_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual mul_if.MONITOR)::get(this, "", "vif", vif))
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface mul_if");
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        mul_item tr;

        if(vif == null)
            return;

        forever begin
            @(vif.mul_cbm);

            tr = mul_item::type_id::create("tr", this);

            tr.rs1 = vif.mul_cbm.rs1;
            tr.rs2 = vif.mul_cbm.rs2;
            tr.sel = vif.mul_cbm.sel;
            tr.data_out = vif.mul_cbm.data_out;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : mul_monitor