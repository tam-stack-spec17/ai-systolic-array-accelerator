`timescale 1ns / 1ps

module tb_axi_wrapper;
    reg clk;
    reg resetn;
    
    // Host to TPU
    reg s_axis_tvalid;
    wire s_axis_tready;
    reg [127:0] s_axis_tdata;
    
    // TPU to Host
    wire m_axis_tvalid;
    reg m_axis_tready;
    wire [255:0] m_axis_tdata;

    // Instantiate the AXI Wrapper
    systolic_array_axi_wrapper uut (
        .clk(clk),
        .resetn(resetn),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata(m_axis_tdata)
    );

    always #5 clk = ~clk;

    initial begin
        // Enable visual waveforms
        $dumpfile("axi_waves.vcd");
        $dumpvars(0, tb_axi_wrapper);

        $monitor("Time: %0t | s_valid: %b | s_ready: %b | m_valid: %b | m_ready: %b", 
                 $time, s_axis_tvalid, s_axis_tready, m_axis_tvalid, m_axis_tready);

        // 1. System Boot (Active Low Reset)
        clk = 0; resetn = 0;
        s_axis_tvalid = 0; s_axis_tdata = 0;
        m_axis_tready = 0;
        
        // 2. Release Reset
        #20 resetn = 1;
        
        // 3. ARM Processor says it is ready to read the final results
        @(posedge clk);
        m_axis_tready = 1;
        
        // 4. Wait for the TPU to announce it is ready to accept data
        wait(s_axis_tready);
        
        // 5. Fire off a massive 128-bit chunk of matrix data!
        @(posedge clk);
        s_axis_tvalid = 1;
        s_axis_tdata = {64'h3E00_3E00_3E00_3E00, 64'h4000_4000_4000_4000};
        
        // 6. Stop sending after one cycle
        @(posedge clk);
        s_axis_tvalid = 0;
        
        // Let the data cascade through the massive array
        repeat(10) @(posedge clk);
        
        #10 $finish;
    end
endmodule
