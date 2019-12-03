`timescale 1ns / 1ps

module temp_sensor_tb();

//settings, simulation, runtime increase to one second

reg clk, reset, start;
reg [7:0]address;
wire [15:0]data;
wire SDA,SDAlocal, SCL;
wire [5:0]count;

reg RW,SDAfs;

assign SDA = RW?SDAfs:1'bz;

temp_sensor t1(clk, reset, address, start, data, SDA, SCL, count);

always #5 clk = ~clk;

initial begin
    clk = 0;
    RW = 0;
    reset = 0;
    start = 0;
    address = 8'b10010001;
end

initial begin 

#20 start = 1;
#10 start = 0;
#90 RW = 1; 
     SDAfs = 0;
#10 SDAfs = 1; //1010010001010101
#10 SDAfs = 0;
#10 SDAfs = 1;
#10 SDAfs = 0;
#10 SDAfs = 0;
#10 SDAfs = 1;
#10 SDAfs = 0;
#10 SDAfs = 0;
#10 RW = 0;
#10 RW = 1;
    SDAfs = 0;
#10 SDAfs = 1;
#10 SDAfs = 0;
#10 SDAfs = 1;
#10 SDAfs = 0;
#10 SDAfs = 1;
#10 SDAfs = 0;
#10 SDAfs = 1;
#10 RW = 0;

end

initial #400 $finish;

endmodule
