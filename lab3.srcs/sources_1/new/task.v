`timescale 1ns / 1ps

module lab_task(
    input clk_in,
    input rst_in,
    
    input [7:0] a_in,
    input [7:0] b_in,
    input start_in,
    
    output busy_out,
    output wire [15:0] y_out
);
wire [7:0] sqrt_out;
wire sqrt_busy;
wire mul_busy;
reg sqrt_step_done;

assign busy_out = sqrt_step_done || sqrt_busy || mul_busy;

sqrt sqrt_instance(
            .x_in(b_in),
            .clk_in(clk_in),
            .rst_in(rst_in),
            .start_in(start_in),
            .busy_out(sqrt_busy),
            .y_out(sqrt_out)
);
multiply multiply_instance(
            .a_in(a_in),
            .b_in(sqrt_out),
            .clk_in(clk_in),
            .rst_in(rst_in),
            .start_in(!sqrt_busy && !start_in),
            .busy_out(mul_busy),
            .y_out(y_out)
);

always @(negedge sqrt_busy) begin
   sqrt_step_done <= 1;
end

always @(negedge mul_busy) begin
   sqrt_step_done <= 0;
end

endmodule
