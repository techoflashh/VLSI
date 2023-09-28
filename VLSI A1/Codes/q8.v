module q8(A,B,EQ,GT);
    input [1:0] A;
    input [1:0] B;
    output EQ,GT;
    wire t1;
    assign t1 = (A[1]~^B[1]);
    assign EQ = ((A[1]~^B[1]) &  (A[0]~^B[0]));
    assign GT = ((A[1] & ~B[1]) | (t1 & A[0] & ~B[0]));
endmodule