module c_dff (input wire D,
input wire clock,
input wire reset,
output reg q_out
);

always @(posedge clock or negedge reset) begin
    if(!reset) begin
        q_out<=1'b0;
    end else begin
       q_out<=D;
    end
end
endmodule
