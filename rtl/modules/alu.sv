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