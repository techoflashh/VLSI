module q3(A,B,C,F1,F2);
    input A,B,C;
    output F1,F2;
    assign F2 = ((A & B) | (B & C) | (A & C));
    assign F1 = A^B^C;
endmodule