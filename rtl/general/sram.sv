module sram (sram_if.DUT sramif);

    reg [7:0] memory [0:2047];
    reg sign_bit;


    always_comb begin
        for(integer i = 0; i < 4; ++i) begin
            if(i < ($unsigned(sramif.num_bytes + 1))) begin
                sramif.read_data[i*8 +: 8] = memory[sramif.addr[10:0] + i];
                sign_bit = memory[sramif.addr[10:0] + i][7];
            end
            else if (sramif.sz)
                sramif.read_data[i*8 +: 8] = {8{sign_bit}};
            else
                sramif.read_data[i*8 +: 8] = 8'h00;
        end
    end

    always_ff @(posedge sramif.clk) begin
        if(sramif.write_enable) begin
            for(integer i = 0; i < ($unsigned(sramif.num_bytes+1)); ++i) begin
                memory[sramif.addr[10:0] + i] <= sramif.write_data[i*8 +: 8];
            end
        end
    end

endmodule : sram