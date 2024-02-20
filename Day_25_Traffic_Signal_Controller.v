/////////////////////////////////Design Block///////////////////////////////////
`define Y2R_delay 5
`define R2G_delay 4
module Traffic_Signal_Controller(hwy,cntry,clear, X, clck);
input X, clck,clear;
output [1:0] hwy,cntry;
reg [1:0] hwy,cntry;
reg [2:0] state, next_state; 
        
parameter Green = 2'b00,
          Yellow = 2'b10,
			 Red = 2'b11;
parameter S0 = 3'b000,
          S1 = 3'b001,
			 S2 = 3'b010,
			 S3 = 3'b011,
			 S4 = 3'b100;
			 
always @(posedge clck)
begin
    if (clear)
	 state = S0;
	 else
	 state = next_state;
end

initial
begin
state <= S0;
next_state <= S0;
end

always @(state)
case (state)
  S0: begin
      hwy = Green;
		cntry = Red;
		end
  S1: begin
      hwy = Yellow;
		cntry = Red;
		end
  S2: begin
      hwy = Red;
		cntry = Red;
		end
  S3: begin
      hwy = Red;
		cntry = Green;
		end
  S4: begin
      hwy = Red;
		cntry = Yellow;
		end
endcase

always @(state or X)
 begin
 case (state)
 S0: begin
     if (X)
	  next_state = S1;
	  else
	  next_state = state;
	  end
 S1: begin
     repeat (`Y2R_delay)
	  @ (posedge clck);
     next_state = S2;
	  end
 S2: begin
     repeat (`R2G_delay)
	  @(posedge clck);
	  next_state = S3;
	  end
 S3: begin
     if (X)
	  next_state = S3;
	  else
	  next_state = S4;
	  end
 S4: begin
     repeat(`Y2R_delay+`R2G_delay)
	  @(posedge clck);
	  next_state = S0;
	  end
endcase
end
endmodule
	  
     
