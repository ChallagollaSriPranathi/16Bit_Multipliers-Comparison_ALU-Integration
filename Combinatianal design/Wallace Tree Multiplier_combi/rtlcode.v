`timescale 1ns / 1ps

module FullAdder (
    input  A, B, Cin,
    output Sum, Cout
);
    assign Sum  = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (Cin & A);
endmodule

module CSA32 (
    input  [31:0] A, B, C,
    output [31:0] Sum, Carry
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : fa_gen
            FullAdder FA (A[i], B[i], C[i], Sum[i], Carry[i]);
        end
    endgenerate
endmodule

module wallace16 (
    input  [15:0] A, B,
    output [31:0] P
);

    wire [31:0] pp [15:0];
    genvar gi;
    generate
        for (gi = 0; gi < 16; gi = gi + 1) begin : pp_gen
            assign pp[gi] = B[gi] ? ({16'b0, A} << gi) : 32'b0;
        end
    endgenerate

    wire [31:0] l1_sum  [4:0];
    wire [31:0] l1_carry[4:0];

    CSA32 L1_0 (pp[0],  pp[1],  pp[2],  l1_sum[0], l1_carry[0]);
    CSA32 L1_1 (pp[3],  pp[4],  pp[5],  l1_sum[1], l1_carry[1]);
    CSA32 L1_2 (pp[6],  pp[7],  pp[8],  l1_sum[2], l1_carry[2]);
    CSA32 L1_3 (pp[9],  pp[10], pp[11], l1_sum[3], l1_carry[3]);
    CSA32 L1_4 (pp[12], pp[13], pp[14], l1_sum[4], l1_carry[4]);

    wire [31:0] l1_out [10:0];
    assign l1_out[0]  = l1_sum[0];
    assign l1_out[1]  = l1_carry[0] << 1;
    assign l1_out[2]  = l1_sum[1];
    assign l1_out[3]  = l1_carry[1] << 1;
    assign l1_out[4]  = l1_sum[2];
    assign l1_out[5]  = l1_carry[2] << 1;
    assign l1_out[6]  = l1_sum[3];
    assign l1_out[7]  = l1_carry[3] << 1;
    assign l1_out[8]  = l1_sum[4];
    assign l1_out[9]  = l1_carry[4] << 1;
    assign l1_out[10] = pp[15];

    wire [31:0] l2_sum  [2:0];
    wire [31:0] l2_carry[2:0];

    CSA32 L2_0 (l1_out[0], l1_out[1], l1_out[2], l2_sum[0], l2_carry[0]);
    CSA32 L2_1 (l1_out[3], l1_out[4], l1_out[5], l2_sum[1], l2_carry[1]);
    CSA32 L2_2 (l1_out[6], l1_out[7], l1_out[8], l2_sum[2], l2_carry[2]);

    wire [31:0] l2_out [7:0];
    assign l2_out[0] = l2_sum[0];
    assign l2_out[1] = l2_carry[0] << 1;
    assign l2_out[2] = l2_sum[1];
    assign l2_out[3] = l2_carry[1] << 1;
    assign l2_out[4] = l2_sum[2];
    assign l2_out[5] = l2_carry[2] << 1;
    assign l2_out[6] = l1_out[9];
    assign l2_out[7] = l1_out[10];

    wire [31:0] l3_sum  [1:0];
    wire [31:0] l3_carry[1:0];

    CSA32 L3_0 (l2_out[0], l2_out[1], l2_out[2], l3_sum[0], l3_carry[0]);
    CSA32 L3_1 (l2_out[3], l2_out[4], l2_out[5], l3_sum[1], l3_carry[1]);

    wire [31:0] l3_out [5:0];
    assign l3_out[0] = l3_sum[0];
    assign l3_out[1] = l3_carry[0] << 1;
    assign l3_out[2] = l3_sum[1];
    assign l3_out[3] = l3_carry[1] << 1;
    assign l3_out[4] = l2_out[6];
    assign l3_out[5] = l2_out[7];

    wire [31:0] l4_sum  [1:0];
    wire [31:0] l4_carry[1:0];

    CSA32 L4_0 (l3_out[0], l3_out[1], l3_out[2], l4_sum[0], l4_carry[0]);
    CSA32 L4_1 (l3_out[3], l3_out[4], l3_out[5], l4_sum[1], l4_carry[1]);

    wire [31:0] l4_out [3:0];
    assign l4_out[0] = l4_sum[0];
    assign l4_out[1] = l4_carry[0] << 1;
    assign l4_out[2] = l4_sum[1];
    assign l4_out[3] = l4_carry[1] << 1;

    wire [31:0] l5_sum, l5_carry;

    CSA32 L5_0 (l4_out[0], l4_out[1], l4_out[2], l5_sum, l5_carry);

    wire [31:0] l5_out [2:0];
    assign l5_out[0] = l5_sum;
    assign l5_out[1] = l5_carry << 1;
    assign l5_out[2] = l4_out[3];

    wire [31:0] l6_sum, l6_carry;

    CSA32 L6_0 (l5_out[0], l5_out[1], l5_out[2], l6_sum, l6_carry);

    assign P = l6_sum + (l6_carry << 1);

endmodule






module FullAdder(input A,B,Cin,output Sum,Cout);
assign Sum=A^B^Cin;
assign Cout=(A&B)|(B&Cin)|(Cin&A);
endmodule

module CSA32(input[31:0] A,B,C,output[31:0] Sum,Carry);
genvar i;
generate for(i=0;i<32;i=i+1) begin
FullAdder FA(A[i],B[i],C[i],Sum[i],Carry[i]);
end endgenerate
endmodule

module wallace16(input[15:0] A,B,output[31:0] P);
wire[31:0] pp[15:0];
genvar i;
generate for(i=0;i<16;i=i+1) begin
assign pp[i]=B[i]?({16'b0,A}<<i):32'b0;
end endgenerate

wire[31:0] s1,c1; CSA32 CSA1(pp[0],pp[1],pp[2],s1,c1);
wire[31:0] s2,c2; CSA32 CSA2(s1,(c1<<1),pp[3],s2,c2);
wire[31:0] s3,c3; CSA32 CSA3(s2,(c2<<1),pp[4],s3,c3);
wire[31:0] s4,c4; CSA32 CSA4(s3,(c3<<1),pp[5],s4,c4);
wire[31:0] s5,c5; CSA32 CSA5(s4,(c4<<1),pp[6],s5,c5);
wire[31:0] s6,c6; CSA32 CSA6(s5,(c5<<1),pp[7],s6,c6);
wire[31:0] s7,c7; CSA32 CSA7(s6,(c6<<1),pp[8],s7,c7);
wire[31:0] s8,c8; CSA32 CSA8(s7,(c7<<1),pp[9],s8,c8);
wire[31:0] s9,c9; CSA32 CSA9(s8,(c8<<1),pp[10],s9,c9);
wire[31:0] s10,c10; CSA32 CSA10(s9,(c9<<1),pp[11],s10,c10);
wire[31:0] s11,c11; CSA32 CSA11(s10,(c10<<1),pp[12],s11,c11);
  wire[31:0] s12,c12; CSA32 CSA12(s11,(c11<<1),pp[13],s12,c12);
wire[31:0] s13,c13; CSA32 CSA13(s12,(c12<<1),pp[14],s13,c13);
wire[31:0] s14,c14; CSA32 CSA14(s13,(c13<<1),pp[15],s14,c14);

assign P=s14+(c14<<1);
endmodule
