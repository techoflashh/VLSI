module q7 (
    input clk,
    input reset,
    input X,
    output reg Y
);
parameter s0 = 0,s1 = 1,s2 = 2;
    
reg[2:0] state,next_state;

always@(posedge clk)begin
  if(reset)begin
    state <= s0;
  end
  else begin
    state <= next_state;
  end
end

always@(state or X)begin
  case(state)
    s0:begin
      Y = 0;
      if(X) next_state = s1;
      else next_state = s0;
    end
    s1:begin
        Y = 1;
        if(X) next_state = s1;
        else next_state = s2;
    end
    s2:begin
      Y = 0;
      next_state = s2;
    end
    default:begin
      next_state = s0;
    end
  endcase
end
endmodule