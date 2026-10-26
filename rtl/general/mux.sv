module mux (mux_if.DUT muxif);

    assign muxif.data_out = muxif.data_in[muxif.sel*$bits(muxif.data_out) +: $bits(muxif.data_out)];

endmodule : mux