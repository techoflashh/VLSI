module Decoder(D,S);
    input [1:0] S;
    output [3:0] D;
    wire Sc0,Sc1;
    not g1(Sc0,S[0]);
    not g2(Sc1,S[1]);
    and g3(D[0],Sc0,Sc1);
    and g4(D[1],S[0],Sc1);
    and g5(D[2],Sc0,S[1]);
    and g6(D[3],S[0],S[1]);
endmodule
