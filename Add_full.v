`timescale 1ns / 1ps

module Add_full(a, b, c_in, s, c_out);
    input a, b, c_in;
    output c_out, s;
    wire w1, w2, w3, w4;
    
    Add_half H1(.a(a),.b(b),.s(w1),.c(w2));
    Add_half H2(.a(w1),.b(c_in),.s(s),.c(w3));
    
    nor(w4,w2,w3);
    not(c_out,w4);
endmodule
