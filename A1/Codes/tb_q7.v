`include "q7.v"
`timescale 1ns/1ns
module tb_fsm;

reg clk,X;
reg rst_n;
wire Y;


q7 call(clk,rst_n,X,Y);

always #5 clk = ~clk;

initial begin
    $dumpfile("tb_q7.vcd");
    $dumpvars(0, tb_fsm);
end

always @(posedge clk) begin
    #5
    $display($time,"ns in = ",X," out =",Y); 
end

initial begin
    clk = 1;
    rst_n =1;
    X = 0;
end

initial begin
    #5;
    rst_n = 0;
    X = 1;
    #10
    rst_n = 0;
    X = 0;
    #10
    rst_n = 0;
    X = 1;
    #10
    rst_n = 0;
    X = 1;
    #10
    rst_n = 0;
    X = 0;
    #10
    rst_n = 1;
    #10 
    rst_n = 0;
    X = 0;
    #10
    rst_n = 0;
    X = 1;
    #10
    rst_n = 0;
    X = 1;
    #10
    $finish;
end
endmodule