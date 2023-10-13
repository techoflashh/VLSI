module Enable(Aout,Bout,A,B,Ein);
    input [3:0] A;
    input [3:0] B;
    input Ein;
    output [3:0] Aout;
    output [3:0] Bout;
    and g1(Aout[3],A[3],Ein);
    and g2(Aout[2],A[2],Ein);
    and g3(Aout[1],A[1],Ein);
    and g4(Aout[0],A[0],Ein);
    and g5(Bout[3],B[3],Ein);
    and g6(Bout[2],B[2],Ein);
    and g7(Bout[1],B[1],Ein);
    and g8(Bout[0],B[0],Ein);
endmodule