module systolic_array_axi_wrapper (
    input wire clk,
    input wire resetn,  // AXI standard uses active-low reset

    // AXI4-Stream Slave (Data flowing IN from ARM CPU)
    input wire s_axis_tvalid,
    output reg s_axis_tready,
    input wire [127:0] s_axis_tdata, // 64-bit Weights + 64-bit Acts

    // AXI4-Stream Master (Data flowing OUT back to ARM CPU)
    output reg m_axis_tvalid,
    input wire m_axis_tready,
    output wire [255:0] m_axis_tdata
);

    // Internal active-high reset for our core
    wire rst = ~resetn;

    // Split the incoming 128-bit AXI bus into our specific TPU buses
    wire [63:0] weights_in = s_axis_tdata[127:64];
    wire [63:0] acts_in    = s_axis_tdata[63:0];

    // Instantiate the giant FP16 Array
    systolic_array_fp16 tpu_core (
        .clk(clk),
        .reset(rst),
        .weights_in(weights_in),
        .acts_in(acts_in),
        .results(m_axis_tdata)
    );

    // Basic AXI Handshake Logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            s_axis_tready <= 1'b0;
            m_axis_tvalid <= 1'b0;
        end else begin
            // The TPU is ready to accept data if the downstream is ready to read
            s_axis_tready <= m_axis_tready;
            
            // If we accepted valid data, flag the output as valid 
            // (Note: In a true deep pipeline, we would delay tvalid by the exact cycle latency)
            if (s_axis_tvalid && s_axis_tready) begin
                m_axis_tvalid <= 1'b1;
            end else if (m_axis_tready) begin
                m_axis_tvalid <= 1'b0;
            end
        end
    end
endmodule
