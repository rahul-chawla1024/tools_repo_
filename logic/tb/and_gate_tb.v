`timescale 1ns/1ps

module and_gate_tb;
    reg a, b;
    wire y;

    // Instantiate the DUT (Device Under Test)
    and_gate uut(.a(a), .b(b), .y(y));

    initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0 , and_gate_tb);
        $monitor("time=%0t | a=%b b=%b -> y=%b", $time, a, b, y);

        // Apply test vectors
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule
