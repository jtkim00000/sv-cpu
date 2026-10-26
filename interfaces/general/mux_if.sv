interface mux_if #(
    parameter DATA_WIDTH = 32,
    PARAMETER INPUT_WIDTH = 2,
    PARAMETER SELECT_BITS = (INPUT_WIDTH > 1) ? $clog2(INPUT_WIDTH) : 1
    );

    logic [DATA_WIDTH*INPUT_WIDTH-1:0] data_in;
    logic [SELECT_BITS-1:0] sel;
    logic [DATA_WIDTH-1:0] data_out;

    modport TEST (
        input data_out,
        output sel, data_in
    );

    modport DUT (
        input sel, data_in,
        output data_out
    );

    modport MONITOR (
        input sel, data_in, data_out
    );

endinterface : mux_if