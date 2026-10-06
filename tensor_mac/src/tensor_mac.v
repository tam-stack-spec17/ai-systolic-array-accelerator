module tensor_mac (
    input clk,
    input reset,
    input [7:0] weight,
    input [7:0] activation,
    output reg [15:0] accumulator
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            accumulator <= 16'b0;
        end else begin
            accumulator <= accumulator + (weight * activation);
        end
    end
endmodule
