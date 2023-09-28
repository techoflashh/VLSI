module comparator(Out,A,B);
    input [3:0] A;
    input [3:0] B;
    output [3:0] Out;
    and g1(Out[3],A[3],B[3]);    
    and g2(Out[2],A[2],B[2]);
    and g3(Out[1],A[1],B[1]);
    and g4(Out[0],A[0],B[0]);
endmodule