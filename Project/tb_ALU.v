`include "ALU.v"

module tb_ALU;
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] S;
    wire [3:0] SumAdd;
    wire [3:0] SumSub;
    wire [3:0] OutAnd;
    wire CarryAdd,CarrySub,Greater,Less,Equal;
    ALU DUT(SumAdd,CarryAdd,SumSub,CarrySub,Greater,Equal,Less,OutAnd,A,B,S);
    initial begin
        $dumpfile("tb_ALU.vcd");
        $dumpvars(0,tb_ALU);
        A = 4'b1001;
        B = 4'b0101;
        S = 2'b01;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        S = 2'b00;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        S = 2'b00;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        S = 2'b00;
        #10
        A = 4'b0010;
        B = 4'b0111;
        S = 2'b00;
        #10
        A = 4'b0011;
        B = 4'b0011;
        S = 2'b01;
        #10
        A = 4'b1001;
        B = 4'b0011;
        S = 2'b01;
        #10
        A = 4'b0110;
        B = 4'b1000;
        S = 2'b00;
        #10
        A = 4'b1111;
        B = 4'b0000;
        S = 2'b01;
        #10
        A = 4'b0000;
        B = 4'b1111;
        S = 2'b00;
        #10
        A = 4'b1001;
        B = 4'b0101;
        S = 2'b01;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        S = 2'b10;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        S = 2'b10;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        S = 2'b10;
        #10
        A = 4'b0010;
        B = 4'b0111;
        S = 2'b10;
        #10
        A = 4'b0011;
        B = 4'b0011;
        S = 2'b10;
        #10
        A = 4'b1001;
        B = 4'b0011;
        S = 2'b10;
        #10
        A = 4'b0110;
        B = 4'b1000;
        S = 2'b10;
        #10
        A = 4'b1111;
        B = 4'b0000;
        S = 2'b10;
        #10
        A = 4'b0000;
        B = 4'b1111;
        S = 2'b10;
        #10
        A = 4'b1001;
        B = 4'b0101;
        S = 2'b10;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        S = 2'b11;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        S = 2'b11;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        S = 2'b11;
        #10
        A = 4'b0010;
        B = 4'b0111;
        S = 2'b11;
        #10
        A = 4'b0011;
        B = 4'b0011;
        S = 2'b11;
        #10
        A = 4'b1001;
        B = 4'b0011;
        S = 2'b11;
        #10
        A = 4'b0110;
        B = 4'b1000;
        S = 2'b11;
        #10
        A = 4'b1111;
        B = 4'b0000;
        S = 2'b11;
        #10
        A = 4'b0000;
        B = 4'b1111;
        S = 2'b11;
        #10
        $finish;
    end
endmodule
