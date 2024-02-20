/////////////////////////////////////design block///////////////////////////
module real_time_clock(sec, min, hr, rst, clk);
input clk, rst;
output [7:0]sec;
output [7:0]min;
output [7:0]hr;
reg [3:0]second[1:0];
reg [3:0]minute[1:0];
reg [3:0]hour[1:0];
assign sec = {second[1],second[0]};
assign min = {minute[1],minute[0]};
assign hr = {hour[1],hour[0]};
initial 
begin
second[1] <= 4'd0;
second[0] <= 4'd0;
minute[0] <= 4'd0;
minute[1] <= 4'd0;
hour[0] <= 4'd0;
hour[1] <= 4'd0;
end
always @(posedge clk)
begin
if (rst)
begin
second[0] <= 4'd0;
second[1] <= 4'd0;
minute[0] <= 4'd0;
minute[1] <= 4'd0;
hour[0] <= 4'd0;
hour[1] <= 4'd0;
end 
else if (second[1]==4'd5 & second[0]==4'd9)
begin
      second[1] = 4'd0;
      second[0] = 4'd0;
      if(minute[0]==4'd9 & minute[1]!= 4'd5)
	     begin
	     minute[0] = 4'd0;
		  minute[1] = minute[1]+1;
		  end
		else if (minute[0]!=4'd9)
		  begin
		  minute[0] = minute[0]+1;
		  end
      if (minute[1]==4'd5 & minute[0]==4'd9)
      begin
           minute[1] = 4'd0;
           minute[0] = 4'd0;
		  if(hour[0]==4'd3 & hour[1]!= 4'd2)
	        begin
	        hour[0] = 4'd0;
		     hour[1] = hour[1]+1;
		     end
		  else if (hour[0]!=4'd3)
		     begin
		     hour[0] = hour[0]+1;
		     end
           if (hour[1]==4'd2 & hour[0]==4'd3)
           begin
                hour[0] = 4'd0;
                hour[0] = 4'd0;
           end
       end
end
else 
begin
     if(second[0]==4'd9 & second[1]!= 4'd5)
	     begin
	     second[0] = 4'd0;
		  second[1] = second[1]+1;
		  end
		else if (second[0]!=4'd9)
		  begin
		  second[0] = second[0]+1;
		  end
end
end
endmodule
///////////////////////////////////Test Bench////////////////////////////////////////
`timescale 1ns/1ps
module real_time_clock_testbench();
reg clk, rst;
wire [7:0]hr, sec, min;
real_time_clock rtc(sec, min, hr, rst, clk);
initial
begin
rst = 1'b0;
clk = 1'b0;
forever #50 clk = ~clk;
end
initial
$monitor (" Hour = %h, Minute = %h" ,hr,min);
initial
#3600 $stop;
endmodule
