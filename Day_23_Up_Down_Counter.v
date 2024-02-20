////////////////////////////DESIGN BLOCK/////////////////////////////////////////
`timescale 1ns / 1ps
module Up_Dwn_Counter(count,clk,clr,n,mode);;
input clr,clk,mode;
input [3:0] n;
output [3:0]count;
reg [3:0]count;
initial
count = 4'b0000;
always @(negedge clk or posedge clr)
count = clr?4'b0000:mode? ((count==n)?4'b0000:count+1):((count==4'b0000)?n:count-1'b1); 
endmodule
///////////////////////////TESTBENCH/////////////////////////////////////////
`timescale 1ns/1ps
module Up_Down_Counter_testbench();
reg clck,n,clr,mode;
wire [3:0]count;
Up_Dwn_Counter ud(count,clck,clr,n,mode);
initial
clck = 1'b0;
initial 
forever #3 clck = ~clck;
initial
begin
#2 n = 4'd10; clr = 1'd0; mode=1'd1;
#8 clr = 1'd1; 
#15 clr = 1'd0; n=4'd15; mode = 1'd0; 
end
initial
$monitor($time,"count = %b"," n = %b", " clr = %b", "mode = %b",count,n,clr,mode);
initial
#50 $stop;
endmodule
