class pc_test extends uvm_test;
    `uvm_component_utils(pc_test)

    pc_env m_top_env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_top_env = pc_env::type_id::create("m_top_env", this);
    endfunction : build_phase

    virtual function void end_of_elaboration_phase();
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    virtual task run_phase(uvm_phase phase);
        pc_sequence m_seq = pc_sequence::type_id::create("m_seq", this);

        phase.raise_objection(this);
        m_seq.start(m_top_env.m_agent.m_sequencer);
        phase.drop_objection(this);
    endtask : run_phase

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);

        uvm_config_db #(uvm_object_wrapper)::set(this, "m_top_env.m_sequencer.run_phase", "default sequence", pc_sequence::type_id::get());

    endfunction : start_of_simulation_phase

endclass : pc_test