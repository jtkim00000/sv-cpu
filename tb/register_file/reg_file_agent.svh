class reg_file_agent extends uvm_agent;
    `uvm_component_utils(reg_file_agent)

    reg_file_driver m_driver;
    reg_file_monitor m_monitor;
    reg_file_sequencer m_sequencer;
    reg_file_coverage m_coverage;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new 

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(get_is_active()) begin
            m_sequencer = reg_file_sequencer::type_id::create("m_sequencer", this);
            m_driver = reg_file_driver::type_id::create("m_driver", this);
        end

        m_monitor = reg_file_monitor::type_id::create("m_monitor", this);
        m_coverage = reg_file_coverage::type_id::create("m_coverage", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active())
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);

        m_monitor.mon_analysis_port.connect(m_coverage.analysis_export);
    endfunction : connect_phase

endclass : reg_file_agent

// uvm_config_db #(uvm_active_passive_enum)::set(this, "path_to_agent", "is_active", UVM_PASSIVE);