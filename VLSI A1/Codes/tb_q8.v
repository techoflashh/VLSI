`include "q8.v"

module q8_tb;
    reg [1:0] A;
    reg [1:0] B;
    wire EQ, GT;

    q8 DUT (.A(A),.B(B),.EQ(EQ),.GT(GT));

    initial begin
        $dumpfile("tb_q8.vcd");
        $dumpvars(0,q8_tb);
        $monitor ($time, " A=%b, B=%b, EQ=%b, GT=%b", A, B, EQ, GT);
        A = 2'b10;
        B = 2'b01;
        #10; 
        A = 2'b11;
        B = 2'b11;
        #10;
        A = 2'b01;
        B = 2'b10;
        #10;
        A = 2'b01;
        B = 2'b00;
        #10
        A = 2'b00;
        B = 2'b01;
        #10
        A = 2'b00;
        B = 2'b00;
        #10
        A = 2'b10;
        B = 2'b00;
        #10
        A = 2'b01;
        B = 2'b00;
        #10
        A = 2'b11;
        B = 2'b00;
        #10
        A = 2'b00;
        B = 2'b11;
        #10
        $finish;
    end
endmodule
