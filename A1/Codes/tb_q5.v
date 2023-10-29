`include "q5.v"
`timescale 1ns/1ns

module q5_tb;
    reg J, K, clk;
    wire Q, Qbar;

    q5 u1 (Q,Qbar,J,K,clk);
    initial begin
        $dumpfile("tb_q5.vcd");
        $dumpvars(0, q5_tb);
    end

    always begin
        clk = ~clk;
        #5;
    end
    
    always @(posedge clk) begin
        #5
        $display($time,"ns Q = ",Q," Qbar =",Qbar);
    end

    initial begin
        J = 0;
        K = 0;
        clk = 0;
        
        #10 J = 1; K = 0;
        #10 J = 0; K = 0;
        #10 J = 0; K = 1;
        #10 J = 0; K = 0;
        #10 J = 1; K = 1;
        #10 J = 1; K = 1;
        #10 J = 0; K = 0; 
        $finish;
    end
endmodule
