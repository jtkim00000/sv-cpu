interface immediate_generator_if;
    logic [31:0] instruction, immediate;

    modport TEST (input immediate, output instruction);

    modport DUT (input instruction, output immediate);

    modport MONITOR (input instruction, immediate);

endinterface : immediate_generator_if