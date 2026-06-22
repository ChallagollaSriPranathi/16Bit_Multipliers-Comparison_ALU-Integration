`timescale 1ns / 1ps

module baugh_wooley_16bit #(
    parameter N = 16
)(
    input  [N-1:0]   A,
    input  [N-1:0]   B,
    output [2*N-1:0] P
);

    wire pp [N-1:0][N-1:0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : row_gen
            for (j = 0; j < N; j = j + 1) begin : col_gen
                localparam SIGN_ROW = (i == N-1);
                localparam SIGN_COL = (j == N-1);
                localparam CORNER   = SIGN_ROW && SIGN_COL;
                localparam INVERT   = (SIGN_ROW || SIGN_COL) && !CORNER;

                if (INVERT)
                    assign pp[i][j] = ~(A[i] & B[j]);
                else
                    assign pp[i][j] = A[i] & B[j];
            end
        end
    endgenerate

    wire [2*N-1:0] row [N-1:0];

    generate
        for (i = 0; i < N; i = i + 1) begin : row_assemble
            wire [2*N-1:0] row_unshifted;
            for (j = 0; j < N; j = j + 1) begin : bit_place
                assign row_unshifted[j] = pp[i][j];
            end
            assign row_unshifted[2*N-1:N] = {N{1'b0}};
            assign row[i] = row_unshifted << i;
        end
    endgenerate

    localparam [2*N-1:0] CORRECTION = (1 << (2*N-1)) + (1 << N);

    wire [2*N-1:0] partial_sum [N:0];
    assign partial_sum[0] = CORRECTION;
    generate
        for (i = 0; i < N; i = i + 1) begin : sum_gen
            assign partial_sum[i+1] = partial_sum[i] + row[i];
        end
    endgenerate

    assign P = partial_sum[N];

endmodule



module baugh_wooley_16bit(input[15:0] A,B,output[31:0] P);

wire pp00=A[0]&B[0],pp01=A[0]&B[1],pp02=A[0]&B[2],pp03=A[0]&B[3],
     pp04=A[0]&B[4],pp05=A[0]&B[5],pp06=A[0]&B[6],pp07=A[0]&B[7],
     pp08=A[0]&B[8],pp09=A[0]&B[9],pp0a=A[0]&B[10],pp0b=A[0]&B[11],
     pp0c=A[0]&B[12],pp0d=A[0]&B[13],pp0e=A[0]&B[14],pp0f=~(A[0]&B[15]);

wire pp10=A[1]&B[0],pp11=A[1]&B[1],pp12=A[1]&B[2],pp13=A[1]&B[3],
     pp14=A[1]&B[4],pp15=A[1]&B[5],pp16=A[1]&B[6],pp17=A[1]&B[7],
     pp18=A[1]&B[8],pp19=A[1]&B[9],pp1a=A[1]&B[10],pp1b=A[1]&B[11],
     pp1c=A[1]&B[12],pp1d=A[1]&B[13],pp1e=A[1]&B[14],pp1f=~(A[1]&B[15]);

wire pp20=A[2]&B[0],pp21=A[2]&B[1],pp22=A[2]&B[2],pp23=A[2]&B[3],
     pp24=A[2]&B[4],pp25=A[2]&B[5],pp26=A[2]&B[6],pp27=A[2]&B[7],
     pp28=A[2]&B[8],pp29=A[2]&B[9],pp2a=A[2]&B[10],pp2b=A[2]&B[11],
     pp2c=A[2]&B[12],pp2d=A[2]&B[13],pp2e=A[2]&B[14],pp2f=~(A[2]&B[15]);

wire pp30=A[3]&B[0],pp31=A[3]&B[1],pp32=A[3]&B[2],pp33=A[3]&B[3],
     pp34=A[3]&B[4],pp35=A[3]&B[5],pp36=A[3]&B[6],pp37=A[3]&B[7],
     pp38=A[3]&B[8],pp39=A[3]&B[9],pp3a=A[3]&B[10],pp3b=A[3]&B[11],
     pp3c=A[3]&B[12],pp3d=A[3]&B[13],pp3e=A[3]&B[14],pp3f=~(A[3]&B[15]);

wire pp40=A[4]&B[0],pp41=A[4]&B[1],pp42=A[4]&B[2],pp43=A[4]&B[3],
     pp44=A[4]&B[4],pp45=A[4]&B[5],pp46=A[4]&B[6],pp47=A[4]&B[7],
     pp48=A[4]&B[8],pp49=A[4]&B[9],pp4a=A[4]&B[10],pp4b=A[4]&B[11],
     pp4c=A[4]&B[12],pp4d=A[4]&B[13],pp4e=A[4]&B[14],pp4f=~(A[4]&B[15]);

wire pp50=A[5]&B[0],pp51=A[5]&B[1],pp52=A[5]&B[2],pp53=A[5]&B[3],
     pp54=A[5]&B[4],pp55=A[5]&B[5],pp56=A[5]&B[6],pp57=A[5]&B[7],
     pp58=A[5]&B[8],pp59=A[5]&B[9],pp5a=A[5]&B[10],pp5b=A[5]&B[11],
     pp5c=A[5]&B[12],pp5d=A[5]&B[13],pp5e=A[5]&B[14],pp5f=~(A[5]&B[15]);

wire pp60=A[6]&B[0],pp61=A[6]&B[1],pp62=A[6]&B[2],pp63=A[6]&B[3],
     pp64=A[6]&B[4],pp65=A[6]&B[5],pp66=A[6]&B[6],pp67=A[6]&B[7],
     pp68=A[6]&B[8],pp69=A[6]&B[9],pp6a=A[6]&B[10],pp6b=A[6]&B[11],
     pp6c=A[6]&B[12],pp6d=A[6]&B[13],pp6e=A[6]&B[14],pp6f=~(A[6]&B[15]);

wire pp70=A[7]&B[0],pp71=A[7]&B[1],pp72=A[7]&B[2],pp73=A[7]&B[3],
     pp74=A[7]&B[4],pp75=A[7]&B[5],pp76=A[7]&B[6],pp77=A[7]&B[7],
     pp78=A[7]&B[8],pp79=A[7]&B[9],pp7a=A[7]&B[10],pp7b=A[7]&B[11],
     pp7c=A[7]&B[12],pp7d=A[7]&B[13],pp7e=A[7]&B[14],pp7f=~(A[7]&B[15]);

wire pp80=A[8]&B[0],pp81=A[8]&B[1],pp82=A[8]&B[2],pp83=A[8]&B[3],
     pp84=A[8]&B[4],pp85=A[8]&B[5],pp86=A[8]&B[6],pp87=A[8]&B[7],
     pp88=A[8]&B[8],pp89=A[8]&B[9],pp8a=A[8]&B[10],pp8b=A[8]&B[11],
     pp8c=A[8]&B[12],pp8d=A[8]&B[13],pp8e=A[8]&B[14],pp8f=~(A[8]&B[15]);

wire pp90=A[9]&B[0],pp91=A[9]&B[1],pp92=A[9]&B[2],pp93=A[9]&B[3],
     pp94=A[9]&B[4],pp95=A[9]&B[5],pp96=A[9]&B[6],pp97=A[9]&B[7],
     pp98=A[9]&B[8],pp99=A[9]&B[9],pp9a=A[9]&B[10],pp9b=A[9]&B[11],
     pp9c=A[9]&B[12],pp9d=A[9]&B[13],pp9e=A[9]&B[14],pp9f=~(A[9]&B[15]);

wire ppa0=A[10]&B[0],ppa1=A[10]&B[1],ppa2=A[10]&B[2],ppa3=A[10]&B[3],
     ppa4=A[10]&B[4],ppa5=A[10]&B[5],ppa6=A[10]&B[6],ppa7=A[10]&B[7],
     ppa8=A[10]&B[8],ppa9=A[10]&B[9],ppaa=A[10]&B[10],ppab=A[10]&B[11],
     ppac=A[10]&B[12],ppad=A[10]&B[13],ppae=A[10]&B[14],ppaf=~(A[10]&B[15]);

wire ppb0=A[11]&B[0],ppb1=A[11]&B[1],ppb2=A[11]&B[2],ppb3=A[11]&B[3],
     ppb4=A[11]&B[4],ppb5=A[11]&B[5],ppb6=A[11]&B[6],ppb7=A[11]&B[7],
     ppb8=A[11]&B[8],ppb9=A[11]&B[9],ppba=A[11]&B[10],ppbb=A[11]&B[11],
     ppbc=A[11]&B[12],ppbd=A[11]&B[13],ppbe=A[11]&B[14],ppbf=~(A[11]&B[15]);

wire ppc0=A[12]&B[0],ppc1=A[12]&B[1],ppc2=A[12]&B[2],ppc3=A[12]&B[3],
     ppc4=A[12]&B[4],ppc5=A[12]&B[5],ppc6=A[12]&B[6],ppc7=A[12]&B[7],
     ppc8=A[12]&B[8],ppc9=A[12]&B[9],ppca=A[12]&B[10],ppcb=A[12]&B[11],
     ppcc=A[12]&B[12],ppcd=A[12]&B[13],ppce=A[12]&B[14],ppcf=~(A[12]&B[15]);

wire ppd0=A[13]&B[0],ppd1=A[13]&B[1],ppd2=A[13]&B[2],ppd3=A[13]&B[3],
     ppd4=A[13]&B[4],ppd5=A[13]&B[5],ppd6=A[13]&B[6],ppd7=A[13]&B[7],
     ppd8=A[13]&B[8],ppd9=A[13]&B[9],ppda=A[13]&B[10],ppdb=A[13]&B[11],
     ppdc=A[13]&B[12],ppdd=A[13]&B[13],ppde=A[13]&B[14],ppdf=~(A[13]&B[15]);
wire ppe0=A[14]&B[0],ppe1=A[14]&B[1],ppe2=A[14]&B[2],ppe3=A[14]&B[3],
     ppe4=A[14]&B[4],ppe5=A[14]&B[5],ppe6=A[14]&B[6],ppe7=A[14]&B[7],
     ppe8=A[14]&B[8],ppe9=A[14]&B[9],ppea=A[14]&B[10],ppeb=A[14]&B[11],
     ppec=A[14]&B[12],pped=A[14]&B[13],ppee=A[14]&B[14],ppef=~(A[14]&B[15]);

wire ppf0=~(A[15]&B[0]),ppf1=~(A[15]&B[1]),ppf2=~(A[15]&B[2]),ppf3=~(A[15]&B[3]),
     ppf4=~(A[15]&B[4]),ppf5=~(A[15]&B[5]),ppf6=~(A[15]&B[6]),ppf7=~(A[15]&B[7]),
     ppf8=~(A[15]&B[8]),ppf9=~(A[15]&B[9]),ppfa=~(A[15]&B[10]),ppfb=~(A[15]&B[11]),
     ppfc=~(A[15]&B[12]),ppfd=~(A[15]&B[13]),ppfe=~(A[15]&B[14]),ppff=A[15]&B[15];

  wire [31:0] row0  = {16'b0,
                         pp0f, pp0e, pp0d, pp0c, pp0b, pp0a,
                         pp09, pp08, pp07, pp06, pp05, pp04,
                         pp03, pp02, pp01, pp00};

    wire [31:0] row1  = {15'b0,
                         pp1f, pp1e, pp1d, pp1c, pp1b, pp1a,
                         pp19, pp18, pp17, pp16, pp15, pp14,
                         pp13, pp12, pp11, pp10,
                         1'b0};

    wire [31:0] row2  = {14'b0,
                         pp2f, pp2e, pp2d, pp2c, pp2b, pp2a,
                         pp29, pp28, pp27, pp26, pp25, pp24,
                         pp23, pp22, pp21, pp20,
                         2'b0};

    wire [31:0] row3  = {13'b0,
                         pp3f, pp3e, pp3d, pp3c, pp3b, pp3a,
                         pp39, pp38, pp37, pp36, pp35, pp34,
                         pp33, pp32, pp31, pp30,
                         3'b0};

    wire [31:0] row4  = {12'b0,
                         pp4f, pp4e, pp4d, pp4c, pp4b, pp4a,
                         pp49, pp48, pp47, pp46, pp45, pp44,
                         pp43, pp42, pp41, pp40,
                         4'b0};

    wire [31:0] row5  = {11'b0,
                         pp5f, pp5e, pp5d, pp5c, pp5b, pp5a,
                         pp59, pp58, pp57, pp56, pp55, pp54,
                         pp53, pp52, pp51, pp50,
                         5'b0};

    wire [31:0] row6  = {10'b0,
                         pp6f, pp6e, pp6d, pp6c, pp6b, pp6a,
                         pp69, pp68, pp67, pp66, pp65, pp64,
                         pp63, pp62, pp61, pp60,
                         6'b0};

    wire [31:0] row7  = {9'b0,
                         pp7f, pp7e, pp7d, pp7c, pp7b, pp7a,
                         pp79, pp78, pp77, pp76, pp75, pp74,
                         pp73, pp72, pp71, pp70,
                         7'b0};

    wire [31:0] row8  = {8'b0,
                         pp8f, pp8e, pp8d, pp8c, pp8b, pp8a,
                         pp89, pp88, pp87, pp86, pp85, pp84,
                         pp83, pp82, pp81, pp80,
                         8'b0};

    wire [31:0] row9  = {7'b0,
                         pp9f, pp9e, pp9d, pp9c, pp9b, pp9a,
                         pp99, pp98, pp97, pp96, pp95, pp94,
                         pp93, pp92, pp91, pp90,
                         9'b0};

    wire [31:0] row10 = {6'b0,
                         ppaf, ppae, ppad, ppac, ppab, ppaa,
                         ppa9, ppa8, ppa7, ppa6, ppa5, ppa4,
                         ppa3, ppa2, ppa1, ppa0,
                         10'b0};

    wire [31:0] row11 = {5'b0,
                         ppbf, ppbe, ppbd, ppbc, ppbb, ppba,
                         ppb9, ppb8, ppb7, ppb6, ppb5, ppb4,
                         ppb3, ppb2, ppb1, ppb0,
                         11'b0};

    wire [31:0] row12 = {4'b0,
                         ppcf, ppce, ppcd, ppcc, ppcb, ppca,
                         ppc9, ppc8, ppc7, ppc6, ppc5, ppc4,
                         ppc3, ppc2, ppc1, ppc0,
                         12'b0};

    wire [31:0] row13 = {3'b0,
                         ppdf, ppde, ppdd, ppdc, ppdb, ppda,
                         ppd9, ppd8, ppd7, ppd6, ppd5, ppd4,
                         ppd3, ppd2, ppd1, ppd0,
                         13'b0};

    wire [31:0] row14 = {2'b0,
                         ppef, ppee, pped, ppec, ppeb, ppea,
                         ppe9, ppe8, ppe7, ppe6, ppe5, ppe4,
                         ppe3, ppe2, ppe1, ppe0,
                         14'b0};

    wire [31:0] row15 = {1'b0,
                         ppff, ppfe, ppfd, ppfc, ppfb, ppfa,
                         ppf9, ppf8, ppf7, ppf6, ppf5, ppf4,
                         ppf3, ppf2, ppf1, ppf0,
                         15'b0};

wire[31:0] corr=32'h80010000;
 assign P = row0  + row1  + row2  + row3
             + row4  + row5  + row6  + row7
             + row8  + row9  + row10 + row11
             + row12 + row13 + row14 + row15
             + corr;

endmodule
