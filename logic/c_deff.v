module c_deff (input wire D,
input wire clock,
input wire reset,
output wire q_out
);

reg q_out1;
reg q_out2;
wire y;

always @(posedge clock or negedge reset) begin
    if(!reset) begin
        q_out1<=1'b0;
    end else begin
       q_out1<=D;
    end
end

always @(posedge ~clock or negedge reset) begin
    if (!reset) begin
        q_out2<=1'b0;
    end else begin
        q_out2<=D;
        end
end

assign q_out = clock?q_out1:q_out2;
assign y = q_out1 | q_out2;
endmodule
