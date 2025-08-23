`timescale 1ns/1ps
module c_mux_2to1_tb;
parameter int WIDTH = 8;
reg [WIDTH-1 : 0]A0;
reg [WIDTH-1 : 0]A1;
reg S0;
wire [WIDTH-1 : 0]out;

c_mux_2to1 #(.WIDTH(WIDTH)) dut(.A0(A0) , .A1(A1) , .S0(S0) , .out(out));
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0 , c_mux_2to1_tb);
    A0 = 8'h00;
    A1 = 0;
    S0 = 8'h00;
    #10 A0=8'hA0;
        S0=0;
        A1=8'h00;
    #10 A0=8'hFF;
        S0=0;
        A1=8'h01;
    #10 A0=8'h00;
        S0=1;
        A1=8'hFE;
    #10 A0=8'h00;
        S0=1;
        A1=8'hAB;
    #10 A0=8'h11;
        S0=0;
        A1=8'h01;
    #10 A0=8'h61;
        S0=0;
        A1=8'h1A;
    #10 A0=8'hA1;
        S0=1;
        A1=8'hAC;
    #10 A0=8'h11;
        S0=1;
        A1=8'hB1;
    #10  A0 = 8'h00;
         S0 = 0;
         A1 = 8'h00;
    #10 A0=8'hA0;
        S0=0;
        A1=8'hA1;
    #10  A0 = 8'hA0;
         S0 = 1;
         A1 = 8'hA1;
    #50 $finish;
end
endmodule