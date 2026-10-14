package alu_pkg;
    typedef enum logic [3:0] {
        ALU_ADD  = 4'd0,
        ALU_SUB  = 4'd1,
        ALU_XOR  = 4'd2,
        ALU_OR   = 4'd3,
        ALU_AND  = 4'd4,
        ALU_SLL  = 4'd5,
        ALU_SRL  = 4'd6,
        ALU_SRA  = 4'd7,
        ALU_SLT  = 4'd8,
        ALU_SLTU = 4'd9,
    } alu_op_t;
endpackage : alu_pkg

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

module alu (alu_if.dut bus);
    import alu_pkg::*;

    always_comb begin
        case (bus.sel)
            ALU_ADD:  bus.s = bus.a + bus.b;
            ALU_SUB:  bus.s = bus.a - bus.b;
            ALU_XOR:  bus.s = bus.a ^ bus.b;
            ALU_OR:   bus.s = bus.a | bus.b;
            ALU_AND:  bus.s = bus.a & bus.b;

            ALU_SLL:  bus.s = bus.a << bus.b[4:0];
            ALU_SRL:  bus.s = bus.a >> bus.b[4:0];
            ALU_SRA:  bus.s = $signed(bus.a) >>> bus.b[4:0];

            ALU_SLT:  bus.s = {31'b0, ($signed(bus.a) < $signed(bus.b))};
            ALU_SLTU: bus.s = {31'b0, (bus.a < bus.b)};
            default:  bus.s = 32'b0;
        endcase
    end

endmodule : alu