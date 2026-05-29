module Booth_radix2(
input signed [15:0]A,   //Multiplicand
input signed [15:0]B,   //Multiplier
output reg signed [31:0]P);
integer i;
reg signed[16:0] A_reg; //accumulator
reg signed[16:0]M;  //Multiplicand
//17 bits taken to prevent overflow
reg signed[15:0]Q;  //Multiplier
reg Q_1;    //previous bit
always@(*) begin
    A_reg=17'b0;
    Q=B;
    Q_1=0;
    M={A[15],A};    //signextend
    for(i=0;i<16;i=i+1) begin
    case({Q[0],Q_1})
        2'b01:A_reg=A_reg+M;
        2'b10:A_reg=A_reg-M;
        default: ;
    endcase
    {A_reg,Q,Q_1}={A_reg[16],A_reg,Q};  //Arithmetic right shift
   end
   P={A_reg[15:0],Q};   //final product
  end
endmodule
