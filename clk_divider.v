`timescale 1ns / 1ps

module clk_divider(clkin, reset, clkout);

input clkin,reset;
output clkout;

reg [5:0]count;
reg clkout;

always @(posedge clkin or posedge reset) begin
    if(reset)  begin
         count <= 0;
         clkout <= 1'b0;
    end
    else if(count == 50) begin   //1MHz clock frequency
        count <=0;
        clkout <= ~clkout;
    end
    else
        count <= (count + 1);
    end
endmodule
