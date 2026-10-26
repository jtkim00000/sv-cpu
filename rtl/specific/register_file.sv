module register_file(register_file_if rfif);
    reg [31:0] register_file [0:31];

    always_ff @(posedge rfif.clk) begin
        if(rfif.write_enable && (rfif.write_addr != 5'd0))
            register_file[rfif.write_addr] <= rfif.write_data;
    end

    always_comb begin
        if(rfif.rs1_addr == rfif.write_addr && rfif.write_enable && rfif.write_addr != 5'd0)
            rfif.rs1 = rfif.write_data;
        else
            rfif.rs1 = (rfif.rs1_addr == 5'd0) ? 32'd0 : register_file[rfif.rs1_addr];
        
        if(rfif.rs2_addr == rfif.write_addr && rfif.write_enable && rfif.write_addr != 5'd0)
            rfif.rs2 = rfif.write_data;
        else
            rfif.rs2 = (rfif.rs2_addr == 5'd0) ? 32'd0 : register_file[rfif.rs2_addr];
    end

endmodule : register_file