module multiplierTree (
    input clk,
    input rst,
    input en,
    input [31:0] a,
    input [31:0] b,
    output [63:0] c
);

wire [31:0] a_out;
wire [31:0] b_out;
wire [63:0] c_out;

buffer #(32) inRegA (clk, rst, en, a, a_out);
buffer #(32) inRegB (clk, rst, en, b, b_out);

wallace M64 (a_out, b_out, c_out);

buffer #(64) outReg (clk, rst, en, c_out, c);

endmodule