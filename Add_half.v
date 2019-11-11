`timescale 1ns / 1ps

module Add_half(a, b, s, c);
    input a, b;
    output c, s;
    wire w1;
    
    xor(s,a,b);
    nand(w1,a,b);
    not(c,w1);
endmodule
