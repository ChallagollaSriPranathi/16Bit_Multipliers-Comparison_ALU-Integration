`timescale 1ns / 1ps

module booth_radix4_seq (
    input               clk,
    input               rst,
    input               start,
    input  signed [15:0] A,
    input  signed [15:0] B,
    output reg signed [31:0] P,
    output reg          done
);

    parameter IDLE = 2'b00;
    parameter RUN  = 2'b01;
    parameter DONE = 2'b10;

    reg  [1:0]          state;
    reg  [3:0]          count;

    reg  signed [17:0]  M;
    reg  signed [31:0]  ACC;
    reg         [15:0]  Q;
    reg                 Q_1;

    reg  signed [31:0]  acc_next;
    reg  signed [48:0]  combined;
    reg  signed [48:0]  combined_shifted;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            ACC   <= 0;
            Q     <= 0;
            Q_1   <= 0;
            M     <= 0;
            count <= 0;
            P     <= 0;
            done  <= 0;
        end
        else begin
            case (state)

                IDLE: begin
                    done <= 0;
                    if (start) begin
                        ACC   <= 0;
                        Q     <= B;
                        Q_1   <= 0;
                        M     <= {{2{A[15]}}, A};
                        count <= 0;
                        state <= RUN;
                    end
                end

                RUN: begin
                    case ({Q[1:0], Q_1})
                        3'b000,
                        3'b111: acc_next = ACC;
                        3'b001,
                        3'b010: acc_next = ACC + M;
                        3'b011: acc_next = ACC + (M <<< 1);
                        3'b100: acc_next = ACC - (M <<< 1);
                        3'b101,
                        3'b110: acc_next = ACC - M;
                        default: acc_next = ACC;
                    endcase

                    combined         = {acc_next, Q, Q_1};
                    combined_shifted = combined >>> 2;

                    ACC   <= combined_shifted[48:17];
                    Q     <= combined_shifted[16:1];
                    Q_1   <= combined_shifted[0];

                    count <= count + 1;
                    if (count == 4'd7)
                        state <= DONE;
                end

                DONE: begin
                    P    <= {ACC[15:0], Q};
                    done <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
