class pc_agent extends __;


    virtual function void built_phase(uvm_phase phase);
        super.build_phase(phase);

        m_sequencer = uvm_sequencer#(pc_item)::type_id::create("m_sequencer", this);
        m_driver = pc_driver::type_id::create("m_driver", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    endfunction : connect_phase

endclass : pc_agent