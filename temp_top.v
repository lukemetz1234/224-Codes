`timescale 1ns / 1ps

module temp_top(clkin,reset,start,SDA,SCL);

input clkin,reset,start;
output SDA,SCL;

wire clkin,reset,start,clk;
wire [5:0]count;
wire SDA,SCL;

wire [7:0]address = 8'b10010001;
wire [15:0]data;

clk_divider c1 (.clkin(clkin), .reset(reset), .clkout(clk));
temp_sensor t1 (.clk(clk), .reset(reset), .address(address), .start(start), .data(data), .SDA(SDA), .SCL(SCL), .count(count));


endmodule
