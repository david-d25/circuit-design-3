`timescale 1ns / 1ps
module bin2bcd(
    input [15:0] bin_in,
    output reg [19:0] bcd_out
);
integer i;
reg [3:0] ones;
reg [3:0] tens;
reg [3:0] hundreds;
reg [3:0] thousands;
reg [3:0] tenthousands;

always @(bin_in) begin
    bcd_out = 20'd0;
    ones = 4'd0;
    tens = 4'd0;
    hundreds = 4'd0;
    thousands = 4'd0;
    tenthousands = 4'd0;
    
    for (i = 15; i >= 0; i = i - 1) begin
        if (tenthousands >= 5)
            tenthousands = tenthousands + 3;
        if (thousands >= 5)
            thousands = thousands + 3;
        if (hundreds >= 5)
            hundreds = hundreds + 3;
        if (tens >= 5)
            tens = tens + 3;
        if (ones >= 5)
            ones = ones + 3;
        
        tenthousands = tenthousands << 1;
        tenthousands[0] = thousands[3];
        thousands = thousands << 1;
        thousands[0] = hundreds[3];
        hundreds = hundreds << 1;
        hundreds[0] = tens[3];
        tens = tens << 1;
        tens[0] = ones[3];
        ones = ones << 1;
        ones[0] = bin_in[i];
    end
    bcd_out = {tenthousands, thousands, hundreds, tens, ones};
end
endmodule
