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