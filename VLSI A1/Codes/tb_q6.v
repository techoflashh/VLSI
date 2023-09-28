`include "q6.v"
`timescale 1ns/1ns
module q6_tb;
reg clk,in;
reg rst_n;
wire out;

q6 call(clk,rst_n,in,out);
always #5 clk = ~clk;
initial begin
    $dumpfile("tb_q6.vcd");
    $dumpvars(0, q6_tb);
end

always @(posedge clk) begin
    #10
    $display($time,"ns in = ",in," out =",out);
end

initial begin
    clk = 1;
    rst_n =1;
    in =0;
end

initial begin
    #10;
    rst_n = 0;
    in = 1;
    #10
    rst_n = 0;
    in = 1;
    #10
    rst_n = 0;
    in = 0;
    #10
    rst_n = 0;
    in = 1;
    #10
    rst_n = 0;
    in = 1;
    #10
    rst_n = 0;
    in = 0;
    #10
    rst_n = 0;
    in = 1;
    #10
    rst_n = 0;
    in = 1;
    #10
    // rst_n = 0;
    // in = 1;
    // #10
    // rst_n = 0;
    // in = 1;
    // #10
    // rst_n = 0;
    // in = 0;
    #10
    $finish;
end
endmodule