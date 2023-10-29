module q6 (
  input clk,
  input reset,
  input in,
  output reg out
);
parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
    
reg[2:0] state,next_state;

always@(posedge clk)begin
  if(reset)begin
    state <= s0;
  end
  else begin
    state <= next_state;
  end
end

always@(state or in)begin
  case(state)
    s0:begin
      out = 0;
      if(in) next_state = s1;
      else next_state = s0;
    end
    s1:begin
        out = 0;
        if(in) next_state = s1;
        else next_state = s2;
    end
    s2:begin
      out = 0;
      if(in) next_state = s3;
      else next_state = s0;
    end
    s3:begin
      out = 0;
      if(in) next_state = s4;
      else next_state = s2;
    end
    s4:begin
        out = 1;
        if(in) next_state = s1;
        else next_state = s2;
    end
    default:begin
      next_state = s0;
    end
  endcase
  end
endmodule