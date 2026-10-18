interface alu_if;
    import alu_pkg::*;

    logic [31:0] a;
    logic [31:0] b;
    alu_op_t     sel;
    logic [31:0] s;

    modport dut (
        input  a, b, sel,
        output s
    );

    modport driver (
        output a, b, sel,
        input  s
    );

    modport monitor (
        input a, b, sel, s
    );

endinterface : alu_if