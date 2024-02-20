//////////////////////////////////design block///////////////////////////////////////////////////////
module Moore_model_DUT(rst,clck,inp,present_out,present_state);
input inp,clck,rst;
output reg present_out;
output [1:0]present_state;
reg next_out;
reg [1:0] present_state,next_state;
localparam s0 = 2'b00,
           s1 = 2'b01,
			  s2 = 2'b10,
			  s3 = 2'b11;
initial 
begin
present_state <= s0;
next_state <= s0;
end
always @(posedge clck , posedge rst)
if (rst)
begin
present_state <= s0;
present_out <= 1'b1;
end
else
begin
present_state <= next_state;
present_out <= next_out;
end
always @(present_state,inp)
begin
if (present_state == s0 & inp == 1)
begin
next_state = s0;
next_out = 1;
end
else if (present_state == s0 & inp==0)
begin
next_state = s1;
next_out = 0;
end
if (present_state == s1 & inp == 1)
begin
next_state = s2;
next_out = 1;
end
else if (present_state == s1 & inp == 0)
begin
next_state = s3;
next_out = 0;
end
if (present_state == s2 & inp == 0)
begin
next_state = s2;
next_out = 1;
end
else if (present_state == s2 & inp == 1)
begin
next_state = s0;
next_out = 1;
end
if (present_state == s3 & inp == 0)
begin
next_out = 0;
next_state = s3;
end
else if (present_state == s3 & inp ==1)
begin
next_state = s2;
next_out = 1;
end
end
endmodule
//////////////////////////////////Test Bench/////////////////////////////////////////////
module Moore_model();
reg inp,clk,rst;
wire prst_out,state;
Moore_model_DUT test(rst,clk,inp,prst_out,state);
initial
clk = 1'b0;
always 
#2 clk = ~clk;
initial 
begin
 rst = 1'b0;
 inp = 1'b1;
 #3 rst = 1'b1;
 #3 rst = 1'b0;
 repeat (5)
 #3 inp = ~inp;
 end
 initial 
 #50 $stop;
 endmodule
 
