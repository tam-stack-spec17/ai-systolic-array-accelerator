// 1. The Core FP16 Engine
module tensor_mac_fp16 (
    input clk,
    input reset,
    input [15:0] weight,
    input [15:0] activation,
    output reg [15:0] result
);
    wire w_sign = weight[15];
    wire [4:0] w_exp = weight[14:10];
    wire [10:0] w_frac = {1'b1, weight[9:0]};

    wire a_sign = activation[15];
    wire [4:0] a_exp = activation[14:10];
    wire [10:0] a_frac = {1'b1, activation[9:0]};

    wire res_sign = w_sign ^ a_sign;
    wire [5:0] res_exp = w_exp + a_exp - 5'd15;
    wire [21:0] res_frac = w_frac * a_frac;

    always @(posedge clk or posedge reset) begin
        if (reset) result <= 16'b0;
        else begin
            if (res_frac[21]) result <= {res_sign, res_exp[4:0] + 1'b1, res_frac[20:11]};
            else result <= {res_sign, res_exp[4:0], res_frac[19:10]};
        end
    end
endmodule

// 2. The 16-Bit Processing Element (PE) Wrapper
module systolic_pe_fp16 (
    input clk,
    input reset,
    input [15:0] w_in,
    input [15:0] a_in,
    output reg [15:0] w_out,
    output reg [15:0] a_out,
    output [15:0] result
);
    tensor_mac_fp16 fp16_core (
        .clk(clk),
        .reset(reset),
        .weight(w_in),
        .activation(a_in),
        .result(result)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_out <= 16'b0;
            a_out <= 16'b0;
        end else begin
            w_out <= w_in;   // Pass 16-bit weight right
            a_out <= a_in;   // Pass 16-bit activation down
        end
    end
endmodule

// 3. The 4x4 FP16 Top-Level Array
module systolic_array_fp16 (
    input clk,
    input reset,
    input [63:0] weights_in, // 4 rows x 16 bits
    input [63:0] acts_in,    // 4 columns x 16 bits
    output [255:0] results   // 16 cores x 16 bits
);
    wire [15:0] w [0:4][0:4];
    wire [15:0] a [0:4][0:4];

    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin : edges
            assign w[i][0] = weights_in[(i*16)+15 : i*16];
            assign a[0][i] = acts_in[(i*16)+15 : i*16];
        end

        for (i = 0; i < 4; i = i + 1) begin : row
            for (j = 0; j < 4; j = j + 1) begin : col
                systolic_pe_fp16 pe (
                    .clk(clk),
                    .reset(reset),
                    .w_in(w[i][j]),
                    .a_in(a[i][j]),
                    .w_out(w[i][j+1]),
                    .a_out(a[i+1][j]),
                    .result(results[((i*4+j)*16)+15 : (i*4+j)*16])
                );
            end
        end
    endgenerate
endmodule
