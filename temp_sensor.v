`timescale 1ns / 1ps

module temp_sensor(clk, reset, address, start, data, SDA, SCL, count);
    input clk, reset;
    input [7:0]address;
    output reg [15:0]data;
    input start;
    output SCL;
    inout wire SDA;
    output reg [5:0]count;
    
    reg [4:0]bit;

    reg sdataW;
    reg RW; //1 means write
    assign SDA = RW?sdataW:1'bZ;
    
    assign SCL = (count==0)?1:clk;

    always @(negedge clk) begin
        if(reset) begin
            count <= 0; //Reset state
            RW <= 1;
            sdataW = 1;
            bit<=0;
        end
        case(count) 
            0 : begin
                RW <= 1;
                sdataW <= 1;
                bit<=0;
                if(start) begin
                    count <= 1;
                end
                else begin
                    count <= 0;
                end
            end
            1 : begin
                RW <= 1;
                case(bit)
                    0 : sdataW <= 0; //START
                    1 : sdataW <= address[7];   //10010001
                    2 : sdataW <= address[6];
                    3 : sdataW <= address[5];
                    4 : sdataW <= address[4];
                    5 : sdataW <= address[3];
                    6 : sdataW <= address[2];
                    7 : sdataW <= address[1];
                    8 : sdataW <= address[0];
                    default : sdataW <= 1'bz;
                endcase
                bit <= bit + 1;
                if(bit >= 9) begin
                    bit <= 0;
                    count <= 2;
                    RW <= 0;
                end
                else count <= 1;
                end
            2 : begin
                RW <= 0;
                if(SDA == 0) begin
                    count <= 3;
                end
                else count <= 0; //something went wrong
            end
            3 : begin
                RW <= 0;
                case(bit)
                    0 : data[15] <= SDA;
                    1 : data[14] <= SDA;
                    2 : data[13] <= SDA;
                    3 : data[12] <= SDA;
                    4 : data[11] <= SDA;
                    5 : data[10] <= SDA;
                    6 : data[9] <= SDA;
                    7 : data[8] <= SDA;
                endcase
                bit <= bit + 1;
                if(bit >= 7) begin
                    bit <= 0;
                    sdataW <= 0;
                    count <= 5;
                    RW <= 1;
                end
                else count <= 3;
             end
             4 : begin
                RW <= 1;
                sdataW <= 0;
                count <= 5;
             end
             5 : begin
                RW <= 0;
                case(bit)
                    0 : ;
                    1 : data[7] <= SDA;
                    2 : data[6] <= SDA;
                    3 : data[5] <= SDA;
                    4 : data[4] <= SDA;
                    5 : data[3] <= SDA;
                    6 : data[2] <= SDA;
                    7 : data[1] <= SDA;
                    8 : data[0] <= SDA;
                endcase
                bit <= bit + 1;
                if(bit >= 8) begin
                    bit <= 0;
                    count <= 7;
                    RW <= 1;
                    sdataW <= 1;
                end
                else count <= 5;
             end
             6 : begin
                RW <= 1;
                sdataW <= 1;
                count <= 7;
             end
             7 : begin
                RW <= 1;
                sdataW <= 0;
                count <= 0;
             end
//             8 : begin
//                RW <= 1;
//                count <= 0;
//                #7 sdataW <= 1;
//             end
            default : begin
                count <= 0;
            end
        endcase
    end
endmodule
