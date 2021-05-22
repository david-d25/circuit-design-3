`timescale 1ns / 1ps

module multiply(
    input clk_in,
    input rst_in,
    
    input [7:0] a_in,
    input [7:0] b_in,
    input start_in,
    
    output busy_out,
    output reg [15:0] y_out
);
    localparam IDLE = 1'b0;
    localparam WORK = 1'b1;
    
    reg     [2:0] counter;
    wire    [2:0] end_step;
    wire    [7:0] part_sum;
    wire   [15:0] shifted_part_sum;
    reg     [7:0] a, b;
    reg    [15:0] result;
    reg           state;
    
    assign part_sum = a & {8{b[counter]}};
    assign shifted_part_sum = part_sum << counter;
    assign end_step = (counter == 3'h7);
    assign busy_out = state;
    
    always @(posedge clk_in) begin
        if (rst_in) begin
            counter <= 0;
            result <= 0;
            y_out <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (start_in) begin
                        state <= WORK;
                        a <= a_in;
                        b <= b_in;
                        counter <= 0;
                        result <= 0;
                    end
                WORK:
                    begin
                        if (end_step) begin
                            state <= IDLE;
                            y_out <= result;
                        end
                    
                    result <= result + shifted_part_sum;
                    counter <= counter + 1;
                    end
            endcase
        end
    end
endmodule
