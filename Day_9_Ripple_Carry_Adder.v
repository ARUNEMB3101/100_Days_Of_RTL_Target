////////////////////////////FULL ADDER DESIGN BLOCK///////////////////////
`timescale 1ns / 1ps
module Full_Adder(sum,carry,a,b,c_in);
input a,b,c_in;
output sum,carry;
wire s1,c1,c2;
xor(s1,a,b);
xor(sum,s1,c_in);
and(c1,a,b);
and(c2,c_in,s1);
or(carry,c1,c2);
endmodule

/////////////////////////////RIPPLE CARRY ADDER DESIGN BLOCK////////////////////////////////
module Ripple_Carry_Adder(sum,c_out,a,b,c_in);
input [3:0]a,b;
output [3:0]sum;
output c_out;
input c_in;
wire c1,c2,c3;
Full_Adder fa0(sum[0],c1,a[0],b[0],c_in);
Full_Adder fa1(sum[1],c2,a[1],b[1],c1);
Full_Adder fa2(sum[2],c3,a[2],b[2],c2);
Full_Adder fa3(sum[3],c_out,a[3],b[3],c3);
endmodule

/////////////////////////////RIPPLE CARRY ADDER TESTBENCH BLOCK////////////////////////////////
module Ripple_Carry_Adder_testbench();
reg [3:0] a,b;
reg c_in;
wire [3:0] sum;
wire carry;
Ripple_Carry_Adder rca(sum,carry,a,b,c_in);
initial
begin
 a=4'd2; b=4'd7; c_in=1'b0;
 #5 a=4'd4; b=6'd11; 
 end
endmodule

