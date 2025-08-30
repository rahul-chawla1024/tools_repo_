module c_mux_nto1 #(parameter int unsigned WIDTH = 4 , parameter int unsigned BUS_WIDTH = 1)
(input [BUS_WIDTH-1:0]A[WIDTH],
 input [$clog2(WIDTH)-1:0]S ,
 output [BUS_WIDTH-1:0]out);
 assign out = S>=WIDTH?0:A[S];
endmodule
