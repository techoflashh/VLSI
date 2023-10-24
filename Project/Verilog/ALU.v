`include "Enable.v"
`include "AdderSubtractor.v"
`include "Comparator.v"
`include "And.v"
`include "Decoder.v"

module ALU(CarryOut,Out,A,B,S);
    output CarryOut;
    output [3:0] Out;
    input [3:0] A;
    input [3:0] B;
    input [1:0] S;
    wire [3:0] SumAdd;
    wire Greater,Equal,Less;
    wire [3:0] OutAnd;
    wire [3:0] D;
    wire [3:0] AinAdd;
    wire [3:0] BinAdd;
    wire [3:0] AinComp;
    wire [3:0] BinComp;
    wire [3:0] AinAnd;
    wire [3:0] BinAnd;
    wire t1;
    Decoder D1(D,S);
    or g1(t1,D[0],D[1]);
    Enable eAnd(AinAnd,BinAnd,A,B,D[3]);
    Enable eComp(AinComp,BinComp,A,B,D[2]);
    Enable eAdd(AinAdd,BinAdd,A,B,t1);
    AdderSubtractor adder(SumAdd,CarryOut,AinAdd,BinAdd,D[1]);
    Comparator comp(Greater,Equal,Less,AinComp,BinComp,D[2]);
    And A1(OutAnd,AinAnd,BinAnd);
    or g2(Out[0],SumAdd[0],Equal,OutAnd[0]);
    or g3(Out[1],SumAdd[1],Less,OutAnd[1]);
    or g4(Out[2],SumAdd[2],Greater,OutAnd[2]);
    or g5(Out[3],SumAdd[3],OutAnd[3]);
endmodule