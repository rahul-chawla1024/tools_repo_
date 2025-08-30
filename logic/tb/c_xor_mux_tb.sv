`timescale 1ns/1ps
module c_xor_mux_tb;
 reg A , B;
    wire Y;

    // Instantiate the DUT (Device Under Test)
    c_xor_mux uut(.A(A), .B(B), .Y(Y));

    initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0 , c_xor_mux_tb);
        // Apply test vectors
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;

        $finish;
    end
endmodule