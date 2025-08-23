`timescale 1ns/1ps
module tb_c_dff;

reg reset , clock , D;
wire q_out;

c_dff DUT(.clock(clock) , .reset(reset) , .D(D) , .q_out(q_out));

initial clock = 0;
always #5 clock = ~clock;

initial begin 
    $dumpfile("wave.vcd");
    $dumpvars(0 , tb_c_dff);

    reset = 0;
    D = 0;
    #13 reset = 1 ;
    #15 D=1;
    #30 D=0;
    #50 D=1;
    #50 $finish;
end
endmodule
