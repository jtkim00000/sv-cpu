program automatic pc_test (
    pc_if.TEST if_t, 
    pc_if.MONITOR if_m
);
    initial begin

        $timeformat(-9, 0,"ns",5);
        $monitor("%t: rdata=%h wdata=%h",
            $realtime, if_m.pc_cbm.rdata, if_m.pc_cbm.wdata
        );

        $display("$t: Reset Signals", $realtime);
        if_t.reset <= 1'b1;
        if_t.wdata <= 32'd12;

        repeat (2) if_t.pc_cb;
        a1: assert (if_t.pc_cb.rdata == 32'd0);


    end

endprogram : pc_test