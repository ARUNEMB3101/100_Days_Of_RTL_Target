///////////////////////////////////////design block///////////////////////////////////
module Mealy_model(clck,rst,inp,out);
input inp,clck,rst;
output reg out;
reg [1:0] present_state,next_state;
parameter s0 = 2'b00,
          s1 = 2'b01,
			 s2 = 2'b10,
			 s3 = 2'b11;
initial
begin
present_state <= 2'b00;
next_state <= 2'b00;
end
always @(posedge clck,posedge rst)
begin
if (rst)
present_state = s0;
else
present_state = next_state;
end
always @(present_state,inp)
begin
if (present_state == s0 & inp == 1'b1)
out = 1'b1;
else if (present_state == s0 & inp == 1'b0)
begin
next_state = s1;
out = 1'b0;
end
if (present_state == s1 & inp == 1'b0)
begin
out = 1'b1;
next_state = s2;
end
else if (present_state == s1 & inp == 1'b1)
begin
out = 1'b0;
next_state = s3;
end
if (present_state == s2 & inp == 1'b0)
begin
out = 1'b1;
next_state = s0;
end
else if (present_state == s2 & inp == 1'b1)
begin
out = 1'b0;
next_state = s1;
end
if (present_state == s3 & inp == 1'b1)
begin
out = 1'b1;
next_state = s2;
end
else if (present_state == s3 & inp == 1'b0)
out = 1'b0;
end
endmodule

