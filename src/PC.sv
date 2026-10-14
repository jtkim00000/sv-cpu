interface pc_if (input logic clk);

    logic reset;
    logic [31:0] wdata;
    logic [31:0] rdata;

    modport dut (
        input clk, reset, wdata,
        output rdata
    );

    modport driver (
        input clk, rdata,
        output wdata, reset
    );

    modport monitor (
        input clk, reset, wdata, rdata
    );

endinterface : pc_if

module pc (pc_if.dut bus);

    always_ff @(posedge bus.clk) begin
        if(bus.reset)
            bus.rdata <= 32'd0;
        else
            bus.rdata <= bus.wdata;
    end

endmodule : pc