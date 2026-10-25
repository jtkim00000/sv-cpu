package alu_pkg

    typedef enum logic [3:0] {
        ALU_ADD  = 4'd0,
        ALU_SUB  = 4'd1,
        ALU_XOR  = 4'd2,
        ALU_OR   = 4'd3,
        ALU_AND  = 4'd4,
        ALU_SLL  = 4'd5,
        ALU_SRL  = 4'46,
        ALU_SRA  = 4'd7,
        ALU_SLT  = 4'd8,
        ALU_SLTU = 4'd9
    } alu_op_t;

endpackage : alu_pkg

module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] sel,
    output logic [31:0] s
    );

    import alu_pkd::*;

    always_comb begin
        case(sel)
            ALU_ADD:  s = a + b;
            ALU_SUB:  s = a - b;
            ALU_XOR:  s = a ^ b;
            ALU_OR:   s = a | b;
            ALU_AND:  s = a & b;
            ALU_SLL:  s = a << b[4:0];
            ALU_SRL:  s = a >> b[4:0];
            ALU_SRA:  s = $signed(a) >> b[4:0];
            ALU_SLT:  s = ($signed(a) < $signed(b)) ? 1 : 0;
            ALU_SLTU: s = ($unsigned(a) < $unsigned(b)) ? 1 : 0;
        endcase
    end

endmodule : alu