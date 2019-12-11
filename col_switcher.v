`timescale 1ns / 1ps

module col_switcher(clk, debounced, row1, row2, row3, row4, key, col1, col2, col3, col4, raw_btn);
input clk, row1, row2, row3, row4, debounced;
output [4:0]key;
output col1, col2, col3, col4, raw_btn;
reg [4:0]key;
reg [3:0]count;
reg [5:0]last_btn;
reg col1, col2, col3, col4, raw_btn ;


always @(posedge clk) begin
    case(last_btn)          //Last key read in
        0   : begin
            col1 <= 0;      //Sets the correct column low to continue reading key 0
            raw_btn <= row4;
            if(row4 == 0) begin     //If the 0 key is pressed
                last_btn <= 0;      //Stay in this case
            end
            else begin
                last_btn <= 16;     //Otherwise exit and check all keys
                if(debounced) begin     //raw_btn is fed into the debouncer module, once the key has been debounced, 
                                    //output the correct key
                key <= 0;      //Key 0
                end
            end
            
        end    
        1   : begin
            col1 <= 0;
            raw_btn <= row1;
            if(row1 == 0) begin
                last_btn <= 1;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                    key <= 1;      //Key 1
                end
            end
            
        end 
        2   : begin
            col2 <= 0;
            raw_btn <= row1;
            if(row1 == 0) begin
                last_btn <= 2;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 2;      //Key 2
            end
            end
            
        end 
        3   : begin
            col3 <= 0;
            raw_btn <= row1;
            if(row1 == 0) begin
                last_btn <= 3;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 3;      //Key 3
            end
            end
            
        end 
        4   : begin
            col1 <= 0;
            raw_btn <= row2;
            if(row2 == 0) begin
                last_btn <= 4;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 4;      //Key 4
            end
            end
            
        end 
        5   : begin
            col2 <= 0;
            raw_btn <= row2;
            if(row2 == 0) begin
                last_btn <= 5;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 5;      //Key 5
            end
            end
            
        end 
        6   : begin
            col3 <= 0;
            raw_btn <= row2;
            if(row2 == 0) begin
                last_btn <= 6;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 6;      //Key 6
            end
            end
            
        end 
        7   : begin
            col1 <= 0;
            raw_btn <= row3;
            if(row3 == 0) begin
                last_btn <= 7;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 7;      //Key 7
            end
            end
            
        end 
        8   : begin
            col2 <= 0;
            raw_btn <= row3;
            if(row3 == 0) begin
                last_btn <= 8;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 8;      //Key 8
            end
            end
            
        end 
        9   : begin
            col3 <= 0;
            raw_btn <= row3;
            if(row3 == 0) begin
                last_btn <= 9;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 9;      //Key 9
            end
            end
            
        end 
        10  : begin
            col4 <= 0;
            raw_btn <= row1;
            if(row1 == 0) begin
                last_btn <= 10;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 10;      //Key A
            end
            end
            
        end     
        11  : begin
            col4 <= 0;
            raw_btn <= row2;
            if(row2 == 0) begin
                last_btn <= 11;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 11;      //Key B
            end
            end
            
        end 
        12  : begin
            col4 <= 0;
            raw_btn <= row3;
            if(row3 == 0) begin
                last_btn <= 12;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 12;      //Key C
            end
            end
            
        end 
        13  : begin
            col4 <= 0;
           raw_btn <= row4;
            if(row4 == 0) begin
                last_btn <= 13;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 13;      //Key D
            end
            end
            
        end 
        14  : begin
            col3 <= 0;
            raw_btn <= row4;
            if(row4 == 0) begin
                last_btn <= 14;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 14;      //Key E
            end
            end
            
        end 
        15  : begin
            col2 <= 0;
            raw_btn <= row4;
            if(row4 == 0) begin
                last_btn <= 15;    
            end
            else begin
                last_btn <= 16;
                if(debounced) begin
                key <= 15;      //Key F
            end
            end
            
        end 
        16  : begin         //Cycles through all columns and reads each row to check for a keypress
        key <=20;
            case(count)
                0:begin
                    
                    col1<=0;    //Set column 1 to low
                    col2<=1;    //Keep all other columns high
                    col3<=1;
                    col4<=1;
                    count<=count +1;    //Increment to next case
                end
                1:begin
                    if(row1 == 0) last_btn <= 1;    //Read each row and set the corresponding key
                    if(row2 == 0) last_btn <= 4;
                    if(row3 == 0) last_btn <= 7;
                    if(row4 == 0) last_btn <= 0;
                    count<=count +1;    //Increment to next case
                end
                2:begin
                    col1<=1;    
                    col2<=0;    //Set column 2 to low
                    col3<=1;    //Keep all other columns high
                    col4<=1;
                    count<=count +1;
                end
                3:begin
                    if(row1 == 0) last_btn <= 2;    //Read each row
                    if(row2 == 0) last_btn <= 5;
                    if(row3 == 0) last_btn <= 8;
                    if(row4 == 0) last_btn <= 15;
                    count<=count +1;    //Increment to next case
                end
                4:begin
                    col1<=1;  
                    col2<=1;
                    col3<=0;
                    col4<=1;
                    count<=count +1;
                end
                5:begin
                    if(row1 == 0) last_btn <= 3;
                    if(row2 == 0) last_btn <= 6;
                    if(row3 == 0) last_btn <= 9;
                    if(row4 == 0) last_btn <= 14;
                    count<=count +1;
                
                end
                6:begin
                    col1<=1;  
                    col2<=1;
                    col3<=1;
                    col4<=0;
                    count<=count +1;
                end
                7:begin
                    if(row1 == 0) last_btn <= 10;
                    if(row2 == 0) last_btn <= 11;
                    if(row3 == 0) last_btn <= 12;
                    if(row4 == 0) last_btn <= 13;
                    count<=0;
                
                end
                
                default: count <= 0;    //Defaults to the first case
            endcase
        end
        default: last_btn <= 16;    //Default to case 16 (read all keys)
    endcase
end
endmodule
