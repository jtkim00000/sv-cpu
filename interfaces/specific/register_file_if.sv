interface register_file_if(input logic clk);

    logic write_enable,
    logic [4:0] rs1_addr, rs2_addr, write_addr;
    logic [31:0] write_data, rs1, rs2;

    clocking register_file_cb @(posedge clk);
        input rs1, rs2,
        output write_enable, rs1_addr. rs2_addr. write_addr, write_data
    endclocking : register_file_cb


    modport TEST (register_file_cb register_file_cb);

    modport DUT (
        input clk, write_enable, rs1_addr, rs2_addr, write_addr, write_data, 
        output rs1, rs2
    );

    clocking register_file_cb_m (posedge clk);
        input write_enable, rs1_addr, rs2_addr. write_addr, write_data, rs1, rs2
    endclocking

    modport MONITOR (register_file_cb_m register_file_cb_m);

endinterface : register_file_if