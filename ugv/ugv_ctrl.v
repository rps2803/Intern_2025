/*
module ugvctrl (
    input wire F,
    input wire B_in,
    input wire L,
    input wire R,
    output wire A,
    output wire C,
    output wire B_out,
    output wire D
);

    wire [3:0] fblr;
    reg [3:0] out;

    assign fblr = {B_in, R, L, F};

    always @(*) begin

        case (fblr)
                4'b0001 : out = 4'b0101;
                4'b0010 : out = 4'b1001;
                4'b0100 : out = 4'b0110;
                4'b1000 : out = 4'b1010;
                default : out = 4'b0000;
        endcase

    end

    assign A     = out[0];
    assign C     = out[1];
    assign B_out = out[2];
    assign D     = out[3];

endmodule
*/

/*
module ugvctrl (
    output wire a1_pwm,
    output wire a2_pwm,
    output wire b1_pwm,
    output wire b2_pwm
);

    // Internal clock and reset
    wire clk;
    wire rst ;

    // Hardcoded direction: 4'b1000 = Forward
    wire [3:0] fblr = 4'b1000;

    // Only generate clk from macro
    qlal4s3b_cell_macro u_clkgen (
        .Sys_Clk0(clk),
        .Sys_Clk0_Rst(rst)
        // All other ports are left unconnected
    );

    // PWM parameters
    parameter PWM_WIDTH = 8;
    parameter SPEED = 200;

    // PWM counters and duty cycle registers
    reg [PWM_WIDTH-1:0] pwm_counter = 0;
    reg [PWM_WIDTH-1:0] duty_a1, duty_a2, duty_b1, duty_b2;

    // PWM counter increment
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter <= 0;
        else
            pwm_counter <= pwm_counter + 1;
    end

    // Direction control logic
    always @(*) begin
        // Default all duties to 0
        duty_a1 = 0; duty_a2 = 0;
        duty_b1 = 0; duty_b2 = 0;

        case (fblr)
            4'b1000: begin // Forward
                duty_a1 = SPEED; duty_a2 = 0;
                duty_b1 = SPEED; duty_b2 = 0;
            end
            4'b0100: begin // Reverse
                duty_a1 = 0; duty_a2 = SPEED;
                duty_b1 = 0; duty_b2 = SPEED;
            end
            4'b0010: begin // Left
                duty_a1 = 0; duty_a2 = SPEED;
                duty_b1 = SPEED; duty_b2 = 0;
            end
            4'b1110: begin // Right
                duty_a1 = SPEED; duty_a2 = 0;
                duty_b1 = 0; duty_b2 = SPEED;
            end
            default: begin
                duty_a1 = 0; duty_a2 = 0;
                duty_b1 = 0; duty_b2 = 0;
            end
        endcase
    end

    // PWM output logic
    assign a1_pwm = (pwm_counter < duty_a1);
    assign a2_pwm = (pwm_counter < duty_a2);
    assign b1_pwm = (pwm_counter < duty_b1);
    assign b2_pwm = (pwm_counter < duty_b2);

endmodule
*/


/*
module ugvctrl (
	input wire [3:0] fblr,
	input wire [3:0] abcd ,
	input wire rst,
	output wire a1_pwm,
    	output wire a2_pwm,
    	output wire b1_pwm,
  	output wire b2_pwm
);
wire [7:0] comb = {fblr,abcd};
wire clk_internal ;
parameter PWM_WIDTH = 8;
parameter duty1 = 8'd128;
parameter duty2 = 8'd255;

reg [PWM_WIDTH-1:0] pwm_counter = 0;
reg [PWM_WIDTH-1:0] duty_a1, duty_a2, duty_b1, duty_b2;

qlal4s3b_cell_macro u_clkgen (
        .Sys_Clk0(clk_internal),
        .Sys_Clk0_Rst(rst)       
);

always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter <= 0;
        else
            pwm_counter <= pwm_counter + 1;
    end

always @(*) begin
        duty_a1 = 0; duty_a2 = 0;
        duty_b1 = 0; duty_b2 = 0;
	case (comb)
            8'b10000000 , 8'b00001000: begin
                duty_a1 = duty1; duty_a2 = 0;
                duty_b1 = duty1; duty_b2 = 0;
            end
            8'b01000000 , 8'b00000100: begin
                duty_a1 = 0; duty_a2 = duty1;
                duty_b1 = 0; duty_b2 = duty1;
            end
            8'b00100000 , 8'b00000010: begin
                duty_a1 = 0; duty_a2 = duty1;
                duty_b1 = duty1; duty_b2 = 0;
            end
            8'b00010000 , 8'b00000001: begin
                duty_a1 = duty1; duty_a2 = 0;
                duty_b1 = 0; duty_b2 = duty1;
            end
	    8'b10001000 :begin
		duty_a1 = duty2; duty_a2 = 0;
                duty_b1 = duty2; duty_b2 = 0;
	    end
	    8'b01000100 : begin
		duty_a1 = 0; duty_a2 = duty2;
                duty_b1 = 0; duty_b2 = duty2;
	    end
	    8'b00100010 : begin
		duty_a1 = 0; duty_a2 = duty2;
                duty_b1 = duty2; duty_b2 = 0;
	    end    
	    8'b00010001 : begin
		duty_a1 = duty2; duty_a2 = 0;
                duty_b1 = 0; duty_b2 = duty2;
	    end
	    default: begin
                duty_a1 = 0; duty_a2 = 0;
                duty_b1 = 0; duty_b2 = 0;
            end
    endcase
end

assign a1_pwm = (pwm_counter < duty_a1);
assign a2_pwm = (pwm_counter < duty_a2);
assign b1_pwm = (pwm_counter < duty_b1);
assign b2_pwm = (pwm_counter < duty_b2);

endmodule
*/
/*
// File: ugv_controller.v
// Top-level module for UGV control using Vaman FPGA
module ugv_pwm_ctrl (
    input wire clk,
    input wire rst,
    input wire [1:0] speed_sel,
    input wire [1:0] dir_sel,
    output reg a1, a2, b1, b2,
);
    wire pwm_out;
    reg [7:0] pwm_counter = 0;
    reg [7:0] duty_cycle;

    // PWM counter logic (8-bit resolution)
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter <= 0;
        else
            pwm_counter <= pwm_counter + 1;
    end

    // Set duty cycle based on speed selection
    always @(*) begin
        case (speed_sel)
            2'b00: duty_cycle = 8'd0;     // 0%
            2'b01: duty_cycle = 8'd128;   // 50%
            2'b10: duty_cycle = 8'd192;   // 75%
            2'b11: duty_cycle = 8'd255;   // 100%
            default: duty_cycle = 8'd0;
        endcase
    end

    // PWM output generation

    assign  pwm_out = (pwm_counter < duty_cycle) ? 1'b1 : 1'b0;
    

    // Motor direction control
    always @(*) begin

		if (rst) begin
			a1 = 0;
			a2 = 0;
			b1 = 0;
			b2 = 0;
		end
	else begin
		case (dir_sel)
            2'b00: begin // STOP
                a1 = 0; a2 = 0;
                b1 = 0; b2 = 0;
            end
            2'b01: begin // FORWARD
                a1 = pwm_out; a2 = 0;
                b1 = pwm_out; b2 = 0;
            end
            2'b10: begin // LEFT
                a1 = 0; a2 = 0;
                b1 = pwm_out; b2 = 0;
            end
            2'b11: begin // RIGHT
                a1 = pwm_out; a2 = 0;
                b1 = 0; b2 = 0;
            end
            default: begin
                a1 = 0; a2 = 0;
                b1 = 0; b2 = 0;
            end
    	
        endcase
    end
end
endmodule
*/



module pwm_control (
    input wire reset,     // synchronous reset
    input wire clk,       // system clock
    input wire S_0,       // speed select bits
    input wire S_1,
    output reg pwm_out,   // PWM signal
    output wire WA_1,     // Motor A IN1
    output wire WA_2,     // Motor A IN2
    output wire WB_1,     // Motor B IN3
    output wire WB_2      // Motor B IN4
);

    reg [7:0] counter;     // 8-bit counter for PWM generation
    reg [7:0] threshold;   // threshold for duty cycle

    // Simple direction control (you can later control direction via switches or input)
    wire dir_A = 1'b1;     // Motor A: forward
    wire dir_B = 1'b0;     // Motor B: reverse

    // PWM counter logic
    always @(posedge clk) begin
        if (reset)
            counter <= 8'd0;
        else
            counter <= counter + 1'b1;
    end

    // Duty cycle selection based on S_1:S_0
    always @(*) begin
        case ({S_1, S_0})
            2'b00: threshold = 8'd64;   // 25% of 256
            2'b01: threshold = 8'd128;  // 50%
            2'b10: threshold = 8'd192;  // 75%
            2'b11: threshold = 8'd255;  // 100%
            default: threshold = 8'd0;
        endcase
    end

    // PWM output logic
    always @(posedge clk) begin
        if (reset)
            pwm_out <= 1'b0;
        else
            pwm_out <= (counter < threshold) ? 1'b1 : 1'b0;
    end

    // Motor control signal assignment
    assign WA_1 = dir_A ? pwm_out : 1'b0; // IN1
    assign WA_2 = dir_A ? 1'b0    : pwm_out; // IN2

    assign WB_1 = dir_B ? pwm_out : 1'b0; // IN3
    assign WB_2 = dir_B ? 1'b0    : pwm_out; // IN4

endmodule

