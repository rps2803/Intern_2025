/*Program for blinking LED
January 16,2021
Code by G V V Sharma
Released under GNU GPL
*/

//declaring the blink module
/*
module helloworldfpga(
    output wire redled,
    output wire greenled,
    output wire blueled
);
    wire clk;

    qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
        .Sys_Clk0 (clk),
    );

    reg[26:0] delay;
     reg	led;
always@(posedge clk) begin
delay = delay+1; //incrementing the counter.
//counts from 0 to 20000000 in 1 second

//if(delay==27'b1001100010010110100000000) // blink delay in bits
if(delay > 10000000) //blink delay in decimal
begin
delay=27'b0;
led=!led; //reset the led
end
end
//    assign blueled = led;	//If you want to change led colour to blue, 
assign redled = led; //If you want to change led colour to red, 
endmodule
//end of the module
*/

/*
//ASSIGNNMENT

module helloworldfpga(
	input a,
	input b,
	output c
);

assign c = a ^ b;
endmodule
*/

/*
module mux2to1(
    input wire a, b,
    input wire sel,
    output wire y
);
    assign y = sel ? b : a;
endmodule

module main(
    output wire led1, led2
);
    wire P = 1'b1;
    wire Q = 1'b1;
    wire R = 1'b1;

    wire first_mux_out, second_mux_out;

    mux2to1 m1(
        .a(1'b0),
        .b(R),
        .sel(P),
        .y(first_mux_out)
    );

    mux2to1 m2(
        .a(~R),
        .b(first_mux_out),
        .sel(Q),
        .y(second_mux_out)
    );

    assign led1 = second_mux_out;
    assign led2 = (~Q & ~R ) | (P & Q & R);
endmodule
*/


module ugvctrl(
    input  wire [3:0] control,
    output reg  [6:0] out
);

    always @(*) begin
        case (control)
            4'b1000 : out = 7'b0100100;   //left - 2
            4'b0100 : out = 7'b0110000;   //right - 3
            4'b0010 : out = 7'b0000000;   //forward - 8
            4'b0001 : out = 7'b0011000;   //backward - 9
            default : out = 7'b1111000;   //default 7
        endcase
    end

endmodule
