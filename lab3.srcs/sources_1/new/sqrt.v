`timescale 1ns / 1ps

module sqrt(
    input wire [7:0] x_in,
    input clk_in,
    input rst_in,
    input start_in,
    
    output busy_out,
    output reg [7:0] y_out
);

localparam IDLE = 1'b0;
localparam WORK = 1'b1;

reg [7:0] x_buffer;
reg [7:0] m;
reg [7:0] b;
reg [7:0] y_buffer;
reg       state;

assign busy_out = state;

always @(posedge clk_in) begin
    if (rst_in) begin
        state <= IDLE;
        x_buffer <= 0;
        m <= 1 << 6;
        y_buffer <= 0;
    end else begin
        case (state)
            IDLE:
                if (start_in) begin
                    state <= WORK;
                    x_buffer <= x_in;
                    m <= 1 << 6;
                    y_out <= 0;
                end
            WORK:
                begin
                    if (m != 0) begin
                        b = y_buffer | m;
                        y_buffer = y_buffer >> 1;
                        if (x_buffer >= b) begin
                            x_buffer = x_buffer - b;
                            y_buffer = y_buffer | m;
                        end
                        m = m >> 2;                                
                    end else begin
                        state <= IDLE;
                        y_out <= y_buffer;
                    end
                end
        endcase
    end
end

endmodule
