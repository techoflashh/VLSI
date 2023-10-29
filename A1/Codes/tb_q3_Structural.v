`include "q3_Structural.v"

module q3_tb;
reg A,B,C; wire F1,F2;
q3 DUT(A,B,C,F1,F2);
initial
    begin  
        $dumpfile("tb_q3_Structural.vcd");
        $dumpvars(0,q3_tb);
        $monitor ($time, " A=%b, B=%b, C=%b, F1=%b, F2=%b", A, B, C, F1, F2);
        #5 A=0; B=0; C=0;
        #5 A=0; B=0; C=1;
        #5 A=0; B=1; C=0;
        #5 A=0; B=1; C=1;
        #5 A=1; B=0; C=0;
        #5 A=1; B=0; C=1;
        #5 A=1; B=1; C=0;
        #5 A=1; B=1; C=1;
        #5 $finish;
    end
endmodule