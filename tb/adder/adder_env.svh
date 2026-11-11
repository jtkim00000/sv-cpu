class adder_env extends uvm_env;
    `uvm_component_utils(adder_env)

    adder_agent m_agent;
    adder_scoreboard m_scoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        m_agent = adder_agent::type_id::create("m_agent", this);
        m_scoreboard = adder_scoreboard::type_id::create("m_scoreboard", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_agent.m_monitor.mon_analysis_port.connect(m_scoreboard.ap_imp);
    endfunction : connect_phase

endclass : adder_env