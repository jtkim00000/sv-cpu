class imm_gen_test extends uvm_test;
    `uvm_component_utils(imm_gen_test)

    imm_gen_env m_top_env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_top_env = imm_gen_env::type_id::create("m_top_env", this);
    endfunction : build_phase

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    virtual task run_phase(uvm_phase phase);
        imm_gen_sequence m_seq = imm_gen_sequence::type_id::create("m_seq");

        phase.raise_objection(this);
        m_seq.start(m_top_env.m_agent.m_sequencer);
        #21
        phase.drop_objection(this);
    endtask : run_phase
endclass : imm_gen_test