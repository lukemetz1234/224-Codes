`timescale 1ns / 1ps

module Add_rca_4(a, b, c_in, sum, c_out);
    input [3:0]a, b;
    input c_in;
    output [3:0]sum;
    output c_out;
    
    wire c_in2, c_in3, c_in4;
    
    Add_full G1(.a(a[0]),.b(b[0]),.c_in(c_in),.s(sum[0]),.c_out(c_in2));
    Add_full G2(.a(a[1]),.b(b[1]),.c_in(c_in2),.s(sum[1]),.c_out(c_in3));
    Add_full G3(.a(a[2]),.b(b[2]),.c_in(c_in3),.s(sum[2]),.c_out(c_in4));
    Add_full G4(.a(a[3]),.b(b[3]),.c_in(c_in4),.s(sum[3]),.c_out(c_out));
endmodule
