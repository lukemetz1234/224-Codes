`timescale 1ns / 1ps

module debounce_btn(clk, btn_state, debounced);

input clk, btn_state;
output debounced;
reg [3:0]counter;   //4 bits to allow for counting up to 4
reg debounced;

always @(posedge clk) begin
    if(btn_state == 0 && counter < 4) begin     //Increment the counter if the button is read as pressed
        counter <= counter + 1;
    end
    else if(btn_state == 1) begin       //If the button is read as not pressed, reset the count
        counter <= 0;
        debounced <= 0;
    end
    if (counter >= 4) begin     //If the button has been read as pressed 4 times
        debounced <= 1;     //Debounced = 1 meaning the button press has been debounced
    end
end

endmodule
