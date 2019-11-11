`timescale 1ns / 1ps

module Add_rca_16_tb();

reg [15:0]a, b;
reg c_in;
wire [15:0]sum;
wire c_out;

Add_rca_16 A1(.a(a),.b(b),.c_in(c_in),.sum(sum),.c_out(c_out));

initial begin
    a = 0;
    b = 0;
    c_in = 0;
end

always #10 a = a+1;
always #15 b = b+1;
always #10 c_in = c_out;

initial #50000 $finish;
endmodule
