`timescale 1ns / 1ps

module Add_rca_16(a, b, c_in, sum, c_out);
    input [15:0]a, b;
    input c_in;
    output [15:0]sum;
    output c_out;
    
    wire c_in4, c_in8, c_in12;
    
    Add_rca_4 M1(.a(a[3:0]),.b(b[3:0]),.c_in(c_in),.sum(sum[3:0]),.c_out(c_in4));
    Add_rca_4 M2(.a(a[7:4]),.b(b[7:4]),.c_in(c_in4),.sum(sum[7:4]),.c_out(c_in8));
    Add_rca_4 M3(.a(a[11:8]),.b(b[11:8]),.c_in(c_in8),.sum(sum[11:8]),.c_out(c_in12));
    Add_rca_4 M4(.a(a[15:12]),.b(b[15:12]),.c_in(c_in12),.sum(sum[15:12]),.c_out(c_out));

endmodule
