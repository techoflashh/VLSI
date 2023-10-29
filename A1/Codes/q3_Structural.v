module q3(A,B,C,F1,F2);
    input A,B,C;
    output F1,F2;
    wire t1,t2,t3,t4,t5,t6,t7;
    and g1(t1,A,B);
    or g2(t2,A,B);
    and g3(t3,t2,C);
    or g4(t4,t2,C);
    and g5(t5,t1,C);
    or g6(F2,t1,t3);
    not g7(t6,F2);
    and g8(t7,t4,t6);
    or g9(F1,t5,t7);
endmodule