`timescale 1ns/1ps
module c_mux_nto1_tb;
parameter int WIDTH = 6;
parameter int BUS_WIDTH = 8;
reg [BUS_WIDTH-1 : 0]A[WIDTH];
reg [$clog2(WIDTH)-1:0]S;
wire [BUS_WIDTH-1 : 0]out;

c_mux_nto1 #(.WIDTH(WIDTH) , .BUS_WIDTH(BUS_WIDTH)) dut(.A(A) , .S(S) , .out(out));
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0 , c_mux_nto1_tb);
    $dumpvars(0 , c_mux_nto1_tb.A[0]);
    $dumpvars(0 , c_mux_nto1_tb.A[1]);
    $dumpvars(0 , c_mux_nto1_tb.A[2]);
    $dumpvars(0 , c_mux_nto1_tb.A[3]);
    A[0] = 8'hA0;
    A[1] = 8'h00;
    A[2] = 8'h00;
    A[3] = 8'h00;
    A[4] = 8'h00;
    A[5] = 8'h00;
    S = 3'b000;
    #10 A[1] = 8'hA1;
    A[0] = 8'h00;
    A[2] = 8'h00;
    A[3] = 8'h00;
    A[4] = 8'h00;
    A[5] = 8'h00;
    S = 3'b001;
    #10 A[2] = 8'hA2;
    A[1] = 8'h00;
    A[0] = 8'h00;
    A[3] = 8'h00;
    A[4] = 8'h00;
    A[5] = 8'h00;
    S = 3'b010;
    #10 A[3] = 8'hA3;
    A[1] = 8'h00;
    A[2] = 8'h00;
    A[0] = 8'h00;
    A[4] = 8'h00;
    A[5] = 8'h00;
    S = 3'b011;
    #10 A[4] = 8'hA4;
    A[1] = 8'h00;
    A[2] = 8'h00;
    A[0] = 8'h00;
    A[3] = 8'h00;
    A[5] = 8'h00;
    S = 3'b100;
    #10 A[5] = 8'hA5;
    A[1] = 8'h00;
    A[2] = 8'h00;
    A[0] = 8'h00;
    A[4] = 8'h00;
    A[3] = 8'h00;
    S = 3'b101;
    #10 S = 3'b110;
    #10 S = 3'b111;
    #50 $finish;

end
endmodule