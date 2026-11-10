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
        BR_EQ    = 4'd10,
        BR_NE    = 4'd11,
        BR_LT    = 4'd12,
        BR_GE    = 4'd13,
        BR_LTU   = 4'd14,
        BR_GEU   = 4'd15
    } alu_op_t;

endpackage : alu_pkg

module alu (alu_if.DUT aluif);

    import alu_pkg::*;

    always_comb begin
        case(aluif.sel)
            ALU_ADD:  aluif.s = aluif.a + aluif.b;
            ALU_SUB:  aluif.s = aluif.a - aluif.b;
            ALU_XOR:  aluif.s = aluif.a ^ aluif.b;
            ALU_OR:   aluif.s = aluif.a | aluif.b;
            ALU_AND:  aluif.s = aluif.a & aluif.b;
            ALU_SLL:  aluif.s = aluif.a << aluif.b[4:0];
            ALU_SRL:  aluif.s = aluif.a >> aluif.b[4:0];
            ALU_SRA:  aluif.s = $signed(aluif.a) >> aluif.b[4:0];
            ALU_SLT:  aluif.s = ($signed(aluif.a) < $signed(aluif.b)) ? 32'd1 : 32'd0;
            ALU_SLTU: aluif.s = ($unsigned(aluif.a) < $unsigned(aluif.b)) ? 32'd1 : 32'd0;
            BR_EQ:    aluif.s = (aluif.a == aluif.b) ? 32'd1 : 32'd0;
            BR_NE:    aluif.s = (aluif.a != aluif.b) ? 32'd1 : 32'd0;
            BR_LT:    aluif.s = ($signed(aluif.a) < $signed(aluif.b)) ? 32'd1 : 32'd0;
            BR_GE:    aluif.s = ($signed(aluif.a) >= $signed(aluif.b)) ? 32'd1 : 32'd0;
            BR_LTU:   aluif.s = ($unsigned(aluif.a) < $unsigned(aluif.b)) ? 32'd1 : 32'd0;
            BR_GEU:   aluif.s = ($unsigned(aluif.a) >= $unsigned(aluif.b)) ? 32'd1 : 32'd0;
            default:  aluif.s = 32'd0;
        endcase
    end

endmodule : alu