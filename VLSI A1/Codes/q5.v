module q5(
    output reg Q,    
    output reg Qbar, 
    input wire J,    
    input wire K,    
    input wire clk  
);
    always @(posedge clk) begin
        if (J == 0 && K == 0) begin
            Q <= Q;
            Qbar <= Qbar;
        end else if (J == 0 && K == 1) begin
            Q <= 1'b0;
            Qbar <= 1'b1;
        end else if (J == 1 && K == 0) begin
            Q <= 1'b1;
            Qbar <= 1'b0;
        end else begin
            Q <= ~Q;
            Qbar <= ~Qbar;
        end
    end

endmodule
