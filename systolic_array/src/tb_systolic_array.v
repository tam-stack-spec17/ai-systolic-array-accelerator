`timescale 1ns / 1ps

module tb_systolic_array;
    reg clk;
    reg reset;
    reg [31:0] weights_in;
    reg [31:0] acts_in;
    wire [255:0] results;

    // Instantiate the 16-core grid
    systolic_array uut (
        .clk(clk),
        .reset(reset),
        .weights_in(weights_in),
        .acts_in(acts_in),
        .results(results)
    );

    // Extract specific cores from the massive 256-bit output bus
    wire [15:0] mac_00 = results[15:0];     // Top-Left Core (Row 0, Col 0)
    wire [15:0] mac_11 = results[95:80];    // Center Core (Row 1, Col 1)
    wire [15:0] mac_33 = results[255:240];  // Bottom-Right Core (Row 3, Col 3)

    always #5 clk = ~clk;

    initial begin
        // Enable visual waveforms
        $dumpfile("array_waves.vcd");
        $dumpvars(0, tb_systolic_array);

        // Print the accumulator values of the three sampled cores
        $monitor("Time: %0t | MAC[0,0]: %4d | MAC[1,1]: %4d | MAC[3,3]: %4d", 
                 $time, mac_00, mac_11, mac_33);

        // Initialize
        clk = 0; reset = 1; 
        weights_in = 32'b0; acts_in = 32'b0;
        #10 reset = 0;

        // Feed continuous static data into the edges of the grid
        // Weights: Row 3=4, Row 2=3, Row 1=2, Row 0=1
        // Acts:    Col 3=4, Col 2=3, Col 1=2, Col 0=1
        @(posedge clk);
        weights_in = {8'd4, 8'd3, 8'd2, 8'd1};
        acts_in    = {8'd4, 8'd3, 8'd2, 8'd1};

        // Let the clock run for 12 cycles to watch the data cascade diagonally
        repeat(12) @(posedge clk);

        #10 $finish;
    end
endmodule
