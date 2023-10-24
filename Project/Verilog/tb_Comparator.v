`include "Comparator.v"

module tb_Comparator;
    reg [3:0] A;
    reg [3:0] B;
    reg En;
    wire Equal, Greater, Less;
    Comparator DUT(Greater,Equal,Less,A,B,En);
    initial begin
        $dumpfile("tb_Comparator.vcd");
        $dumpvars(0,tb_Comparator);
        $monitor ($time, "En=%b A=%b, B=%b, Equal=%b, Greater=%b, Less=%b", En, A, B, Equal, Greater, Less);
        A = 4'b1001;
        B = 4'b0101;
        En = 1;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        En = 1;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        En = 1;
        #10;
        A = 4'b0101;
        B = 4'b0001;
        En = 1;
        #10
        A = 4'b0010;
        B = 4'b0111;
        En = 1;
        #10
        A = 4'b0011;
        B = 4'b0011;
        En = 0;
        #10
        A = 4'b1001;
        B = 4'b0011;
        En = 1;
        #10
        A = 4'b0110;
        B = 4'b1000;
        En = 1;
        #10
        A = 4'b1111;
        B = 4'b0000;
        En = 0;
        #10
        A = 4'b0000;
        B = 4'b1111;
        En = 1;
        #10
        $finish;
    end
endmodule
