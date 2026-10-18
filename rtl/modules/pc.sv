module pc (pc_if.dut bus);

    always_ff @(posedge bus.clk) begin
        if(bus.reset)
            bus.rdata <= 32'd0;
        else
            bus.rdata <= bus.wdata;
    end

endmodule : pc