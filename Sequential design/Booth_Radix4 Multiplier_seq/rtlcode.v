`timescale 1ns / 1ps 

module booth_radix4_seq(
    input clk,
    input rst,
    input start,
    input signed [15:0] A,
    input signed [15:0] B,
    output reg signed [31:0] P,
    output reg done
);

    parameter IDLE = 2'b00;
    parameter RUN  = 2'b01;
    parameter DONE = 2'b10;

    reg [1:0] state;

    reg signed [31:0] product;
    reg signed [31:0] M;
    reg signed [15:0] Q;
    reg Q_1;
    reg [3:0] count;

    reg signed [31:0] temp;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state   <= IDLE;
            product <= 0;
            M       <= 0;
            Q       <= 0;
            Q_1     <= 0;
            count   <= 0;
            P       <= 0;
            done    <= 0;
        end

        else begin
            case(state)

            IDLE: begin
                done <= 0;

                if(start) begin
                    product <= 0;
                    M       <= {{16{A[15]}},A};
                    Q       <= B;
                    Q_1     <= 0;
                    count   <= 0;
                    state   <= RUN;
                end
            end

            RUN: begin

                case({Q[1:0],Q_1})
                    3'b000,
                    3'b111 : temp = 0;

                    3'b001,
                    3'b010 : temp = M;

                    3'b011 : temp = M <<< 1;

                    3'b100 : temp = -(M <<< 1);

                    3'b101,
                    3'b110 : temp = -M;

                    default: temp = 0;
                endcase

                product <= product + (temp <<< (2*count));

                {Q,Q_1} <= {Q,Q_1} >>> 2;

                count <= count + 1;

                if(count == 4'd7)
                    state <= DONE;
            end

            DONE: begin
                P    <= product;
                done <= 1'b1;
                state <= IDLE;
            end

            endcase
        end
    end

endmodule
