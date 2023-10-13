`include "Decoder.v"

module tb_Decoder;
    reg [1:0] S;
    wire [3:0] D;
    Decoder DUT(D,S);
    initial begin
        $dumpfile("tb_Decoder.vcd");
        $dumpvars(0,tb_Decoder);
        S = 2'b00;
        #10; 
        S = 2'b01;
        #10;
        S = 2'b10;
        #10;
        S = 2'b11;
        #10
        S = 2'b00;
        #10
        S = 2'b11;
        #10
        $finish;
    end
endmodule
