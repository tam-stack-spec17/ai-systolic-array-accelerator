`timescale 1ns / 1ps

module tb_tensor_mac_fp16;
    reg clk;
    reg reset;
    reg [15:0] weight;
    reg [15:0] activation;
    wire [15:0] result;

    // Instantiate the FP16 engine
    tensor_mac_fp16 uut (
        .clk(clk),
        .reset(reset),
        .weight(weight),
        .activation(activation),
        .result(result)
    );

    always #5 clk = ~clk;

    initial begin
        // Enable visual waveforms
        $dumpfile("fp16_waves.vcd");
        $dumpvars(0, tb_tensor_mac_fp16);

        $monitor("Time: %0t | W (hex): %h | A (hex): %h | Result (hex): %h", 
                 $time, weight, activation, result);

        // Initialize
        clk = 0; reset = 1; weight = 0; activation = 0;
        #10 reset = 0;

        // Test Case 1: 1.5 * 2.0 = 3.0
        // 1.5 in FP16 is 0_01111_1000000000 -> Hex: 3E00
        // 2.0 in FP16 is 0_10000_0000000000 -> Hex: 4000
        // Expected 3.0 is 0_10000_1000000000 -> Hex: 4200
        @(posedge clk); 
        weight = 16'h3E00; 
        activation = 16'h4000;
        
        // Wait for the calculation
        repeat(2) @(posedge clk);
        
        #10 $finish;
    end
endmodule
