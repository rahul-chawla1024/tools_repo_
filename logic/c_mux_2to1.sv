module c_mux_2to1 #(parameter int unsigned WIDTH = 1)
(input wire [WIDTH-1 : 0]A0,
input wire [WIDTH-1 : 0]A1,
input wire S0,
output wire [WIDTH-1 : 0]out);
assign out = S0?A1:A0;
endmodule
