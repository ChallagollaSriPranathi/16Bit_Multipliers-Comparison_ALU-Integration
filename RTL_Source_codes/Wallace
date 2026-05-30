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
wire[31:0] s12,c12; CSA32 CSA12(s11,(c12<<1),pp[13],s12,c12);
wire[31:0] s13,c13; CSA32 CSA13(s12,(c12<<1),pp[14],s13,c13);
wire[31:0] s14,c14; CSA32 CSA14(s13,(c13<<1),pp[15],s14,c14);

assign P=s14+(c14<<1);
endmodule
