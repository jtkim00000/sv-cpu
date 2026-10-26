package mul_pkg;

    typedef enum logic [2:0] {
        MUL_L   = 3'd0,
        MUL_H   = 3'd1,
        MUL_HU  = 3'd2,
        MUL_HSU = 3'd3,
        DIV     = 3'd4,
        DIV_U   = 3'd5,
        REM     = 3'd6,
        REM_U   = 3'd7
    } mul_op_t;

endpackage : mul_pkg

module mul (mul_if.DUT mulif);
    import mul_pkg::*;

    logic [63:0] product;

    always_comb begin
        product = 64'd0;
        mulif.data_out = 32'd0;

        case(mulif.sel)
            MUL_L: begin
                product = $signed(mulif.rs1) * $signed(mulif.rs2);
                mulif.data_out = product[31:0];
            end
            MUL_H: begin
                product = $signed(mulif.rs1) * $signed(mulif.rs2);
                mulif.data_out = product[63:32];
            end
            MUL_HU: begin
                product = $unsigned(mulif.rs1) * $unsigned(mulif.rs2);
                mulif.data_out = product[63:32];
            end
            MUL_HSU: begin
                product = $signed({{32{mulif.rs1[31]}}, mulif.rs1}) * $signed({32'b0, mulif.rs2});
                mulif.data_out = product[63:32];
            end
            DIV: begin
                if(mulif.rs2 == 32'd0)
                    mulif.data_out = 32'hFFFFFFFF;
                else if((mulif.rs1 == 32'h8000_0000) && (mulif.rs2 == 32'hFFFFFFFF))
                    mulif.data_out = 32'h80000000;
                else
                    mulif.data_out = $signed(mulif.rs1) / $signed(mulif.rs2);
            end
            DIV_U: begin  
                if(mulif.rs2 == 32'd0)
                    mulif.data_out = 32'hFFFFFFFF;
                else
                    mulif.data_out = $unsigned(mulif.rs1) / $unsigned(mulif.rs2);
            end
            REM: begin
                if(mulif.rs2 == 32'd0)
                    mulif.data_out = mulif.rs1;
                else if((mulif.rs1 == 32'h8000_0000) && (mulif.rs2 == 32'hFFFFFFFF))
                    mulif.data_out = 32'd0;
                else
                    mulif.data_out = $signed(mulif.rs1) % $signed(mulif.rs2);
            end
            REM_U: begin
                if(mulif.rs2 == 32'd0)
                    mulif.data_out = mulif.rs1;
                else
                    mulif.data_out = $unsigned(mulif.rs1) % $unsigned(mulif.rs2);
            end
            default: begin
                // Keep default values as assigned above
            end
        endcase
    end

endmodule : mul