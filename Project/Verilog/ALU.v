`include "Enable.v"
`include "AdderSubtractor.v"
`include "Comparator.v"
`include "And.v"
`include "Decoder.v"

module ALU(SumAdd,CarryAdd,SumSub,CarrySub,Greater,Equal,Less,OutAnd,A,B,S);
    output [3:0] SumAdd;
    output CarryAdd;
    output [3:0] SumSub;
    output CarrySub;
    output Greater,Equal,Less;
    output [3:0] OutAnd;
    input [3:0] A;
    input [3:0] B;
    input [1:0] S;
    wire [3:0] D;
    wire [3:0] AinAdd;
    wire [3:0] BinAdd;
    wire [3:0] AinSub;
    wire [3:0] BinSub;
    wire [3:0] AinComp;
    wire [3:0] BinComp;
    wire [3:0] AinAnd;
    wire [3:0] BinAnd;
    Decoder D1(D,S);
    Enable eAnd(AinAnd,BinAnd,A,B,D[3]);
    Enable eComp(AinComp,BinComp,A,B,D[2]);
    Enable eSub(AinSub,BinSub,A,B,D[1]);
    Enable eAdd(AinAdd,BinAdd,A,B,D[0]);
    AdderSubtractor adder(SumAdd,CarryAdd,AinAdd,BinAdd,D[1]);
    AdderSubtractor subtractor(SumSub,CarrySub,AinSub,BinSub,D[1]);
    Comparator comp(Greater,Equal,Less,AinComp,BinComp,D[2]);
    And A1(OutAnd,AinAnd,BinAnd);
endmodule