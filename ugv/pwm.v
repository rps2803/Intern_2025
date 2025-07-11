module ugv_pwm_ctrl (
    input wire clk,
    input wire rst,

    input wire sel0, sel1,         // Speed selection buttons
    input wire dir0, dir1,         // Direction control buttons

    output wire pwm_out_left,
    output wire pwm_out_right,

    output reg in1, in2, in3, in4  // Direction control pins to motor driver
);

    reg [7:0] duty_cycle;

    // Duty cycle logic
    always @(*) begin
        case ({sel1, sel0})
            2'b00: duty_cycle = 8'd0;    // 0%
            2'b01: duty_cycle = 8'd128;  // 50%
            2'b10: duty_cycle = 8'd204;  // 80%
            2'b11: duty_cycle = 8'd255;  // 100%
            default: duty_cycle = 8'd0;
        endcase
    end

    // Direction logic
    always @(*) begin
        case ({dir1, dir0})
            2'b00: begin // Stop
                in1 = 0; in2 = 0;
                in3 = 0; in4 = 0;
            end
            2'b01: begin // Forward
                in1 = 1; in2 = 0;
                in3 = 1; in4 = 0;
            end
            2'b10: begin // Left
                in1 = 0; in2 = 1;
                in3 = 1; in4 = 0;
            end
            2'b11: begin // Right
                in1 = 1; in2 = 0;
                in3 = 0; in4 = 1;
            end
        endcase
    end

    // PWM generator
    reg [7:0] pwm_counter;
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter <= 0;
        else
            pwm_counter <= pwm_counter + 1;
    end

    assign pwm_out_left = (pwm_counter < duty_cycle) ? 1'b1 : 1'b0;
    assign pwm_out_right = (pwm_counter < duty_cycle) ? 1'b1 : 1'b0;

endmodule

