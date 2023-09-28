module q4(
    output reg out,
    output reg [3:0] count,
    input wire clk,
    input wire reset
);

always @(posedge clk) begin
    if (reset==1) begin
        out = 1'b0;
        count = 4'b0;
    end
    
    if (count == 15) begin
        count <= 0;
        out <= 0;
    end else begin
        count <= count + 3;
        if (count == 9) begin
            out <= 1;
        end
    end
end

endmodule
