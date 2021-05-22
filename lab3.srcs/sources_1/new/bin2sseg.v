`timescale 1ns / 1ps

module bin2sseg(
input [3:0] value_in,
output [7:0] value_out
);
wire [3:0] neg_value_in;
assign neg_value_in = ~value_in;

// asign value_out[0] = 0;
wire a0, a1;
and(a0, neg_value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
and(a1, neg_value_in[3], value_in[2], neg_value_in[1], neg_value_in[0]);
or(value_out[0], a0, a1);

// assign value_out[1] = 0;
wire b0, b1;
and(b0, neg_value_in[3], value_in[2], neg_value_in[1], value_in[0]);
and(b1, neg_value_in[3], value_in[2], value_in[1], neg_value_in[0]);
or(value_out[1], b0, b1);

// assign value_out[2] = 0;
and(value_out[2], neg_value_in[3], neg_value_in[2], value_in[1], neg_value_in[0]);

// assign value_out[3] = 0;
wire d0, d1, d2;
and(d0, neg_value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
and(d1, neg_value_in[3], value_in[2], neg_value_in[1], neg_value_in[0]);
and(d2, neg_value_in[3], value_in[2], value_in[1], value_in[0]);
or(value_out[3], d0, d1, d2);

// assign value_out[4] = 0;
wire e0, e1, e2, e3, e4, e5;
and(e0, neg_value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
and(e1, neg_value_in[3], neg_value_in[2], value_in[1], value_in[0]);
and(e2, neg_value_in[3], value_in[2], neg_value_in[1], neg_value_in[0]);
and(e3, neg_value_in[3], value_in[2], neg_value_in[1], value_in[0]);
and(e4, neg_value_in[3], value_in[2], value_in[1], value_in[0]);
and(e5, value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
or(value_out[4], e0, e1, e2, e3, e4, e5);

//assign value_out[5] = 0;
wire f0, f1, f2, f3;
and(f0, neg_value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
and(f1, neg_value_in[3], neg_value_in[2], value_in[1], neg_value_in[0]);
and(f2, neg_value_in[3], neg_value_in[2], value_in[1], value_in[0]);
and(f3, neg_value_in[3], value_in[2], value_in[1], value_in[0]);
or(value_out[5], f0, f1, f2, f3);

//assign value_out[6] = 0;
wire g0, g1, g2;
and(g0, neg_value_in[3], neg_value_in[2], neg_value_in[1], neg_value_in[0]);
and(g1, neg_value_in[3], neg_value_in[2], neg_value_in[1], value_in[0]);
and(g2, neg_value_in[3], value_in[2], value_in[1], value_in[0]);
or(value_out[6], g0, g1, g2);

assign value_out[7] = 1;
endmodule
