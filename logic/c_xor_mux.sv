module c_xor_mux(
 input A,
 input B,
 output Y);
 wire bint;
 assign bint = B?1'b0:1'b1;
 assign Y = A?bint:B;
endmodule
