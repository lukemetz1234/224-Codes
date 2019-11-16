`timescale 1ns / 1ps

module LCD_Top(clk, reset, data, RS, E, R_nW, state);
input clk, reset;
output [7:0]data;
output RS, E, R_nW;
output [3:0]state;

wire clk1MHz;
wire [7:0]data;
wire RS, E, R_nW;

LCD L1(.clk(clk1MHz), .reset(reset), .data(data), .E(E), .RS(RS), .R_nW(R_nW), .state(state));
clk_divider C1(.clkin(clk), .reset(reset), .clkout(clk1MHz));

endmodule
