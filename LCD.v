`timescale 1ns / 1ps


module LCD(clk, reset, data, E, RS, R_nW, state);
input clk, reset;
output [7:0]data;
output E, RS, R_nW;
output [3:0]state;

parameter resetS = 4'b0000, delay20 = 4'b0001, setFunc = 4'b0010, delay37 = 4'b0011, setDisp = 4'b0100,
 delay37two = 4'b0101, clrDisp = 4'b0110, delay15 = 4'b0111, writeDisp = 4'b1000, delay26 = 4'b1001, entryMode = 4'b1010, delay37three = 4'b1011;
 
reg [3:0]state;
reg [7:0] data;
reg E, RS, R_nW;
reg [14:0]counter;
reg [3:0]letter;

initial begin
    state <= resetS;
    data <= 0;
    E <= 0;
    RS <= 0;
    R_nW <= 0;
    counter <= 0;
end
    
always @(posedge clk) begin
    if(reset) begin
        state <= resetS;
    end
    case(state)
        resetS : begin
            data <= 0;
            E <= 0;
            RS <= 0;
            state <= delay20;
        end
        delay20 : begin
            state <= delay20;
            counter <= counter + 1;
            if(counter >= 20000) begin
                state <= setFunc;
                counter <= 0;
            end
        end
        setFunc : begin
            RS <= 0;
            R_nW <= 0;
            data <= 8'b00111100;    //00111000
            E <= 1;
            state <= delay37;
        end
        delay37 : begin
            E <= 0;
            state <= delay37;
            counter <= counter + 1;
            if(counter >= 37) begin
                state <= setDisp;
                counter <= 0;
            end
        end
        setDisp : begin
            RS <= 0;
            R_nW <= 0;
            data <= 8'b00001111;
            E <= 1;
            state <= delay37two;
        end
        delay37two : begin
            E <= 0;
            state <= delay37two;
            counter <= counter + 1;
            if(counter >= 37) begin
                state <= clrDisp;
                counter <= 0;
            end
        end
        clrDisp : begin
            RS <= 0;
            R_nW <= 0;
            data <= 8'b00000001;
            E <= 1;
            state <= delay15;
        end
        delay15 : begin
            E <= 0;
            state <= delay15;
            counter <= counter + 1;
            if(counter >= 1520) begin
                state <= entryMode;
                counter <= 0;
            end
        end
        entryMode : begin
            RS <= 0;
            R_nW <= 0;
            data <= 8'b00000111;
            E <= 1;
            state <= delay37three;
        end
        delay37three : begin
            E <= 0;
            state <= delay37three;
            counter <= counter + 1;
            if(counter >= 37) begin
                state <= writeDisp;
                counter <= 0;
            end
        end
        writeDisp : begin
            case(letter)
            0: data <= 8'b01001000; //H
            1: data <= 8'b01000101; //E
            2: data <= 8'b01001100; //L
            3: data <= 8'b01001100; //L
            4: data <= 8'b01001111; //O
            5: data <= 8'b00100000; 
            6: data <= 8'b01010111; //W
            7: data <= 8'b01001111; //O
            8: data <= 8'b01010010; //R
            9: data <= 8'b01001100; //L 
            10: data <= 8'b01000100; //D
            11: data <= 8'b00100000;
            12: data <= 8'b00100000;
            default: data <= 8'b00100000;
            endcase
            letter = letter+1;
            if(letter == 12) letter <= 0;
            RS <= 1;
            E <= 1;
            R_nW <= 0;
            state <= delay26;
        end
        delay26 : begin
            RS <= 1;
            E <= 0;
            state <= delay26;
            counter <= counter + 1;
            if(counter >= 26000) begin
                state <= writeDisp;
                counter <= 0;
            end
        end
        default : begin
            state <= resetS;
        end
    endcase
    
end

endmodule
