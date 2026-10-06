// 1. The Core MAC Engine (Your original design)
module tensor_mac (
    input clk,
    input reset,
    input [7:0] weight,
    input [7:0] activation,
    output reg [15:0] accumulator
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            accumulator <= 16'b0;
        else
            accumulator <= accumulator + (weight * activation);
    end
endmodule

// 2. The Processing Element (PE) Wrapper
// Adds flip-flops to pass data to the next PE in the grid
module systolic_pe (
    input clk,
    input reset,
    input [7:0] w_in,
    input [7:0] a_in,
    output reg [7:0] w_out,
    output reg [7:0] a_out,
    output [15:0] acc
);
    tensor_mac mac_core (
        .clk(clk),
        .reset(reset),
        .weight(w_in),
        .activation(a_in),
        .accumulator(acc)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_out <= 8'b0;
            a_out <= 8'b0;
        end else begin
            w_out <= w_in;   // Pass weight to the right
            a_out <= a_in;   // Pass activation downwards
        end
    end
endmodule

// 3. The 4x4 Top-Level Systolic Array
module systolic_array (
    input clk,
    input reset,
    input [31:0] weights_in, // 4 rows x 8 bits
    input [31:0] acts_in,    // 4 columns x 8 bits
    output [255:0] results   // 16 MACs x 16 bits
);
    // Interconnect wires for the grid
    wire [7:0] w [0:4][0:4];
    wire [7:0] a [0:4][0:4];

    genvar i, j;
    generate
        // Connect the external inputs to the top and left edges
        for (i = 0; i < 4; i = i + 1) begin : edges
            assign w[i][0] = weights_in[(i*8)+7 : i*8];
            assign a[0][i] = acts_in[(i*8)+7 : i*8];
        end

        // Instantiate the 16 Processing Elements in a grid
        for (i = 0; i < 4; i = i + 1) begin : row
            for (j = 0; j < 4; j = j + 1) begin : col
                systolic_pe pe (
                    .clk(clk),
                    .reset(reset),
                    .w_in(w[i][j]),
                    .a_in(a[i][j]),
                    .w_out(w[i][j+1]),
                    .a_out(a[i+1][j]),
                    .acc(results[((i*4+j)*16)+15 : (i*4+j)*16])
                );
            end
        end
    endgenerate
endmodule
