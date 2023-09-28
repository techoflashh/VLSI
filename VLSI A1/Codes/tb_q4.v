`include "q4.v"

module q4_tb;
wire [3:0] count;
reg clk;
reg reset;
wire out;

q4 DUT(.out(out),.count(count),.clk(clk),.reset(reset));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("tb_q4.vcd");
    $dumpvars(0, q4_tb);
    clk = 0;
    reset = 1;
    #10 reset = 0;
    #200;
    $finish;
end

always @(posedge clk) begin
    $display("Time=%0t, count=%b, out=%b", $time, count, out);
end

endmodule