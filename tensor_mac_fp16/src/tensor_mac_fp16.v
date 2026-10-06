module tensor_mac_fp16 (
    input clk,
    input reset,
    input [15:0] weight,      // 1 Sign, 5 Exponent, 10 Fraction
    input [15:0] activation,
    output reg [15:0] result
);
    // Unpack the IEEE 754 FP16 Bits
    wire w_sign = weight[15];
    wire [4:0] w_exp = weight[14:10];
    wire [10:0] w_frac = {1'b1, weight[9:0]}; // Add implicit 1

    wire a_sign = activation[15];
    wire [4:0] a_exp = activation[14:10];
    wire [10:0] a_frac = {1'b1, activation[9:0]};

    // Hardware Math Paths
    wire res_sign = w_sign ^ a_sign;
    wire [5:0] res_exp = w_exp + a_exp - 5'd15;     // Subtract bias
    wire [21:0] res_frac = w_frac * a_frac;         // 11-bit x 11-bit multiplier

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 16'b0;
        end else begin
            // Simple Normalization & Repacking
            if (res_frac[21]) begin
                result <= {res_sign, res_exp[4:0] + 1'b1, res_frac[20:11]};
            end else begin
                result <= {res_sign, res_exp[4:0], res_frac[19:10]};
            end
        end
    end
endmodule
