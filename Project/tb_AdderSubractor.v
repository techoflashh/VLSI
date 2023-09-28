`include "AdderSubtractor.v"

module tb_AdderSubractor;
    reg [3:0] A;
    reg [3:0] B;
    reg M;
    wire [3:0] Sum;
    wire Carry;
    AdderSubtractor DUT(Sum,Carry,A,B,M);
    initial begin
        $dumpfile("tb_AdderSubractor.vcd");
        $dumpvars(0,tb_AdderSubractor);
        $monitor ($time, " A=%b, B=%b, M=%b, Sum=%b, Carry=%b", A, B, M, Sum, Carry);
        A = 4'b1001;
        B = 4'b0101;
        M = 1;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        M = 0;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        M = 0;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        M = 0;
        #10
        A = 4'b0010;
        B = 4'b0111;
        M = 0;
        #10
        A = 4'b0011;
        B = 4'b0011;
        M = 1;
        #10
        A = 4'b1001;
        B = 4'b0011;
        M = 1;
        #10
        A = 4'b0110;
        B = 4'b1000;
        M = 0;
        #10
        A = 4'b1111;
        B = 4'b0000;
        M = 1;
        #10
        A = 4'b0000;
        B = 4'b1111;
        M = 0;
        #10
        $finish;
    end
endmodule
