`timescale 1ns / 1ps

module tb_tensor_mac_pipe;
    reg clk;
    reg reset;
    reg [7:0] weight;
    reg [7:0] activation;
    wire [15:0] accumulator;

    // Instantiate the pipelined engine
    tensor_mac_pipe uut (
        .clk(clk),
        .reset(reset),
        .weight(weight),
        .activation(activation),
        .accumulator(accumulator)
    );

    // Generate a 200MHz clock (5.0ns period)
    always #2.5 clk = ~clk;

    initial begin
        // Enable visual waveforms
        $dumpfile("pipe_waves.vcd");
        $dumpvars(0, tb_tensor_mac_pipe);

        $monitor("Time: %0t | W: %3d | A: %3d | Acc: %4d", 
                 $time, weight, activation, accumulator);

        // Initialize
        clk = 0; reset = 1; weight = 0; activation = 0;
        #10 reset = 0;

        // Feed Data Stream
        @(posedge clk); weight = 3;  activation = 4;   // Input 1
        @(posedge clk); weight = 5;  activation = 2;   // Input 2 (Input 1 is multiplying)
        @(posedge clk); weight = 10; activation = 10;  // Input 3 (Input 1 is added, Input 2 is multiplying)
        
        // Wait for the pipeline to flush the remaining calculations
        repeat(4) @(posedge clk);
        
        #10 $finish;
    end
endmodule
