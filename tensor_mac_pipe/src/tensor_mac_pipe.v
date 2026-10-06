module tensor_mac_pipe (
    input clk,
    input reset,
    input [7:0] weight,
    input [7:0] activation,
    output reg [15:0] accumulator
);
    // The Pipeline Register
    reg [15:0] mult_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mult_reg <= 16'b0;
            accumulator <= 16'b0;
        end else begin
            // Pipeline Stage 1: Multiply
            mult_reg <= weight * activation;
            
            // Pipeline Stage 2: Accumulate
            accumulator <= accumulator + mult_reg;
        end
    end
endmodule
