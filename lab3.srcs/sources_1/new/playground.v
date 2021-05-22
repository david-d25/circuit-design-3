`timescale 1ns / 1ps

module playground(
    input [15:0] SW,
    input CLK100MHZ,
    input CPU_RESETN,
    input BTNC,
    input BTNU,
    output [7:0] AN,
    output [15:0] LED,
    output [7:0] sseg_cat
);

wire [15:0] solver_result;

lab_task solver(
    .clk_in(CLK100MHZ),
    .rst_in(BTNU),
    .a_in(SW[15:8]),
    .b_in(SW[7:0]),
    .start_in(BTNC),
    .y_out(solver_result)
);

wire [19:0] bcd_result;
bin2bcd bin2bcd(
    .bin_in(solver_result),
    .bcd_out(bcd_result)
);

wire [39:0] sseg_out; 
bin2sseg bin2sseg0(.value_in(bcd_result[3:0]),      .value_out(sseg_out[39:32]) );
bin2sseg bin2sseg1(.value_in(bcd_result[7:4]),      .value_out(sseg_out[31:24]) );
bin2sseg bin2sseg2(.value_in(bcd_result[11:8]),     .value_out(sseg_out[23:16]) );
bin2sseg bin2sseg3(.value_in(bcd_result[15:12]),    .value_out(sseg_out[15:8])  );
bin2sseg bin2sseg4(.value_in(bcd_result[19:16]),    .value_out(sseg_out[7:0])   );

assign LED = bcd_result[15:0];

reg [39:0] digits = 40'b0;
reg [4:0] an_sel = 5'b01111;
reg [31:0] counter = 0;

always @(posedge CLK100MHZ) begin
    counter <= counter + 1;
    if (counter == 32'd400000) begin
        if (an_sel == 5'b01111) begin
            digits = sseg_out;
        end
        an_sel <= {an_sel[0], an_sel[4:1]};
        digits = {digits[7:0], digits[39:32],  digits[31:24], digits[23:16], digits[15:8]};
        counter <= 0;
    end
end

assign AN = {3'b111, an_sel};
assign sseg_cat = digits[7:0];
endmodule
