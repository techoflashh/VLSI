`include "And.v"

module tb_And;
    reg [3:0] A;
    reg [3:0] B;
    wire [3:0] Out;
    And DUT(Out,A,B);
    initial begin
        $dumpfile("tb_And.vcd");
        $dumpvars(0,tb_And);
        $monitor ($time, " A=%b, B=%b, A.B=%b", A, B, Out);
        A = 4'b1001;
        B = 4'b0101;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        #10
        A = 4'b0010;
        B = 4'b0111;
        #10
        A = 4'b0011;
        B = 4'b0011;
        #10
        A = 4'b1001;
        B = 4'b0011;
        #10
        A = 4'b0110;
        B = 4'b1000;
        #10
        A = 4'b1111;
        B = 4'b0000;
        #10
        A = 4'b0000;
        B = 4'b1111;
        #10
        $finish;
    end
endmodule
