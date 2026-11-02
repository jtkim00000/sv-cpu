`include "uvm_macros.svh"

package tb_pkg;

    import uvm_pkg::*;

    class my_env extends uvm_env;
        `uvm_component_utils(my_env)

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction : new

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        endfunction : build_phase

        task run_phase(uvm_phase phase);
            `uvm_info(get_name(), $sformatf("Hello UVM! Simulation has started."), UVM_LOW)
        endtask : run_phase

    endclass : my_env

    class base_test extends uvm_test;
        `uvm_component_utils(base_test)

        my_env m_top_env;

        function new (string name, uvm_component parent = null);
            super.new(name, parent);
        endfunction : new

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            m_top_env = my_env::type_id::create("m_top_env", this);
        endfunction : build_phase

        virtual function void end_of_elaboration_phase(uvm_phase phase);
            uvm_top.print_topology();
        endfunction : end_of_elaboration_phase

    endclass : base_test
endpackage : tb_pkg

module tb_top;

    import uvm_pkg::*;
    import tb_pkg::*;

    initial begin
        run_test("base_test");
    end

endmodule : tb_top