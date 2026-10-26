module pc (pc_if.DUT pcif);

    always_ff @(posedge pcif.clk) begin
        if(pcif.reset)
            pcif.read_data <= 32'd0;
        else
            pcif.read_data <= pcif.write_data;
    end

endmodule : pc