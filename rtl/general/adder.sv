module adder (adder_if.DUT adderif);

    always_comb begin
        adderif.s = adderif.a + adderif.b;
    end

endmodule : adder