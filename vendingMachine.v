`timescale 1ns / 1ps

module vendingMachine(clk, reset, nickle, dime, change, product);

input clk, reset;
input nickle, dime;
output change, product;

reg [5:0]state;
reg change, product;

always @(posedge clk) begin
    if(reset) begin
        state <= 0;
        change <= 0;
        product <= 0;
    end
    case(state)
        0 : begin               //$0.00 Entered
        product <= 0;
        change <= 0;
            if(nickle) begin    //Nickle input
                state <= 1;     //$0.05 state
                change <= 0;
                product <= 0;
            end
            else if(dime) begin //Dime input
                state <= 2;     //$0.10 state
                change <= 0;
                product <= 0;
            end
            else state <= 0;
        end
        1 : begin               //$0.05 Entered
            if(nickle) begin    //Nickle entered
                state <= 2;     //$0.10 state
                change <= 0;
                product <= 0;
            end
            else if(dime) begin //Dime entered
                state <= 3;     //$0.15 state
                change <= 0;
                product <= 0;
            end
            else state <= 1;
        end
        2 : begin               //$0.10 Entered
            if(nickle) begin    //Nickle entered
                state <= 3;     //$0.15 state
                change <= 0;
                product <= 0;
            end
            else if(dime) begin //Dime entered
                state <= 4;     //$0.20 state
                change <= 0;
                product <= 0;
            end
            else state <= 2;
        end
        3 : begin               //$0.15 Entered
            product <= 1;       //Dispense product
            change <= 0;        //Reset change to zero
            state <= 0;         //Go back to $0.00 state
        end
        4 : begin               //$0.20 state
            product <= 1;       //Dispense product
            change <= 1;        //Dispense a nickle
            state <= 0;         //Go back to $0.00 state
        end
        default : begin
            state <= 0;
            change <= 0;
            product <= 0;
        end
    endcase
end

endmodule
