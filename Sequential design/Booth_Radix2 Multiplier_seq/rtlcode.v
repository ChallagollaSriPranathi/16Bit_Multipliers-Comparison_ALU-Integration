`timescale 1ns / 1ps

module booth_multiplier_seq (
    input clk,
    input rst,
    input start,
    input signed [15:0] A,
    input signed [15:0] B,
    output reg signed [31:0] P,
    output reg done
);

    reg signed [16:0] A_reg;
    reg signed [15:0] Q;
    reg Q_1;
    reg signed [16:0] M;
    reg [4:0] count;

    reg signed [16:0] A_temp;
    reg signed [33:0] booth_temp;

    parameter IDLE   = 2'b00;
    parameter RUN    = 2'b01;
    parameter FINISH = 2'b10;

    reg [1:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A_reg <= 0;
            Q     <= 0;
            Q_1   <= 0;
            M     <= 0;
            P     <= 0;
            count <= 0;
            done  <= 0;
            state <= IDLE;
        end
        else begin
            case(state)

                IDLE: begin
                    done <= 0;

                    if(start) begin
                        A_reg <= 0;
                        Q     <= B;
                        Q_1   <= 0;
                        M     <= {A[15], A};
                        count <= 0;
                        state <= RUN;
                    end
                end

                RUN: begin

                    // Booth add/subtract
                    A_temp = A_reg;

                    case({Q[0], Q_1})
                        2'b01: A_temp = A_reg + M;
                        2'b10: A_temp = A_reg - M;
                        default: A_temp = A_reg;
                    endcase

                    // Arithmetic right shift
                    booth_temp = {A_temp, Q, Q_1};
                    booth_temp = booth_temp >>> 1;

                    A_reg <= booth_temp[33:17];
                    Q     <= booth_temp[16:1];
                    Q_1   <= booth_temp[0];

                    count <= count + 1;

                    if(count == 5'd15)
                        state <= FINISH;
                end

                FINISH: begin
                    P    <= {A_reg[15:0], Q};
                    done <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;

            endcase
        end
    end

endmodule 
