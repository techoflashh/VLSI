`include "Enable.v"

module tb_Enable;
    reg [3:0] A;
    reg [3:0] B;
    reg Ein;
    wire [3:0] Aout;
    wire [3:0] Bout;
    Enable DUT(Aout,Bout,A,B,Ein);
    initial begin
        $dumpfile("tb_Enable.vcd");
        $dumpvars(0,tb_Enable);
        A = 4'b1001;
        B = 4'b0101;
        Ein = 1;
        #10; 
        A = 4'b1100;
        B = 4'b1100;
        Ein = 0;
        #10;
        A = 4'b0100;
        B = 4'b1001;
        Ein = 1;
        #10;
        $finish;
    end
endmodule
