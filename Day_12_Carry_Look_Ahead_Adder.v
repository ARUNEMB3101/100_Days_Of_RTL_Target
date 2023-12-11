///////////////////////////////design_block////////////////////////////////
`timescale 1ns / 1ps
module Carry_Look_Ahead_Adder(sum,cout,a,b,cin);
input [3:0]a,b;
input cin;
output cout;
output [3:0]sum;
wire p0,p1,p2,p3,g0,g1,g2,g3,c1,c2,c3;
assign p0=a[0]^b[0],
p1=a[1]^b[1],
p2=a[2]^b[2],
p3=a[3]^b[3],
g0=a[0]&b[0],
g1=a[1]&b[1],
g2=a[2]&b[2],
g3=a[3]&b[3],
c1=g0|(cin&p0),
c2=g1|(c1&p1),
c3=g2|(c2&p2),
cout=g3|(c3&p3),
sum[0]=p0^cin,
sum[1]=p1^c1,
sum[2]=p2^c2,
sum[3]=p3^c3;
endmodule

/////////////////////////////Carry Look Ahead Adder TESTBENCH BLOCK////////////////////////////////
module Carry_Look_Head_Adder_testbench();
reg [3:0] a,b;
reg c_in;
wire [3:0] sum;
wire c_out;
Carry_Look_Ahead_Adder claa(sum,c_out,a,b,c_in);
initial
begin
 a=4'd2; b=4'd7; c_in=1'b1;
 #5 a=4'd4; b=6'd11; 
 end
endmodule


