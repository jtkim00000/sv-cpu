class imm_gen_monitor extends uvm_monitor;
    `uvm_component_utils(imm_gen_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual immediate_generator_if.MONITOR vif;

    uvm_analysis_port #(imm_gen_item) mon_analysis_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        mon_analysis_port = new("mon_analysis_port", this);

        if(!uvm_config_db #(virtual immediate_generator_if.MONITOR)::get(this, "", "vif", vif))
            `uvm_error(get_type_name(), "Didn't get handle to virtual interface imm_gen_if");
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        imm_gen_item tr;

        if(vif == null)
            return;

        forever begin
            @(vif.imm_gen_cbm);

            tr = imm_gen_item::type_id::create("tr", this);

            tr.instruction = vif.imm_gen_cbm.instruction;
            tr.immediate = vif.imm_gen_cbm.immediate;

            mon_analysis_port.write(tr);
        end

    endtask : run_phase

endclass : imm_gen_monitor