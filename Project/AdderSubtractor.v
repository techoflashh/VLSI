module fullAdder(Cout,S,A,B,Cin);
    input A,B,Cin;
    output Cout,S;
    wire S1out,C1out,C2out;
    xor g1(S1out,A,B);
    xor g2(S,S1out,Cin);
    and g3(C1out,A,B);
    and g4(C2out,S1out,Cin);
    or g5(Cout,C1out,C2out);
endmodule

module AdderSubtractor(Sum,Carry,A,B,M);
    input [3:0] A;
    input [3:0] B;
    input M;
    output [3:0] Sum;
    output Carry;
    wire Cout0,Cout1,Cout2;
    wire B3,B2,B1,B0;
    xor g1(B2,M,B[2]);
    xor g2(B1,M,B[1]);
    xor g3(B3,M,B[3]);
    xor g4(B0,M,B[0]);
    fullAdder ins1(Cout0,Sum[0],A[0],B0,M);
    fullAdder ins2(Cout1,Sum[1],A[1],B1,Cout0);
    fullAdder ins3(Cout2,Sum[2],A[2],B2,Cout1);
    fullAdder ins4(Carry,Sum[3],A[3],B3,Cout2);
endmodule