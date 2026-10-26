
module immediate_generator (immediate_generator_if.DUT imm_genif);
    always_comb begin
            case(imm_genif.instruction[6:0])
            //I-Type
            7'b0010011, 7'b0000011, 7'b1100111, 7'b1110011: begin
                imm_genif.immediate = {{21{imm_genif.instruction[31]}}, imm_genif.instruction[30:20]};
            end
            //S-Type
            7'b0100011: begin
                imm_genif.immediate = {{21{imm_genif.instruction[31]}}, imm_genif.instruction[30:25], imm_genif.instruction[11:7]};
            end
            //B-Type
            7'b1100011: begin
                imm_genif.immediate = {{20{imm_genif.instruction[31]}}, imm_genif.instruction[7], imm_genif.instruction[30:25], imm_genif.instruction[11:8], 1'b0};
            end
            //U-Type
            7'b0110111, 7'b0010111: begin
                imm_genif.immediate = {imm_genif.instruction[31:12], 12'd0};
            end
            //J-Type
            7'b1101111: begin
                imm_genif.immediate = {{12{imm_genif.instruction[31]}}, imm_genif.instruction[19:12], imm_genif.instruction[20], imm_genif.instruction[30:21], 1'b0};
            end

            default: imm_genif.immediate = 32'd0;
        endcase
    end

endmodule : imm_genif.immediate_generator