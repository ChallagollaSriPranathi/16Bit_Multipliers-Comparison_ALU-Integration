module Booth_radix4(
input signed [15:0]A,
input signed [15:0]B,
output reg signed [31:0]P);
integer i;
reg signed [31:0] A_reg;
reg signed [15:0] Q;
reg Q_1;
reg signed [31:0] M;
reg signed [31:0] temp;
always @(*) begin
A_reg=32'd0;
Q=B;
Q_1=1'b0;
M={{16{A[15]}},A};
  for(i=0;i<8;i=i+1) begin
    case({Q[1:0],Q_1})
         3'b000,3'b111:temp=32'd0;
         3'b001,3'b010:temp=M;
         3'b011:temp=M<<<1;
         3'b100:temp=-(M<<<1);
         3'b101,3'b110:temp=-M;
         default: temp=32'd0;
    endcase
   A_reg=A_reg+(temp<<<(2*i));
   {Q,Q_1}={Q,Q_1}>>>2;
 end
P=A_reg;
end
endmodule
