////////////////////////////////////////Design_Block_Excess_3_to_BCD//////////////////////////////
`timescale 1ns/1ps
module Excess_3_to_BCD(a,b,c,d,w,x,y,z);
input w,x,y,z;
output a,b,c,d;
assign a=(w&x)|(w&y&z);
assign b=(~x&~y)|(~x&~z)|(x&y&z);
assign c=(~y&z)|(y&~z);
assign d =~z;
endmodule    

////////////////////////////////////////Design_Block_BCD_to_Excess_3//////////////////////////////
`timescale 1ns / 1ps
module BCD_to_Excess_3(w,x,y,z,a,b,c,d);
input a,b,c,d;
output w,x,y,z;
assign w= a|(b&c)|(b&d);
assign x= (~b&c)|(~b&d)|(b&~c&~d);
assign y= (c&d)+(~c&~d);
assign z = ~d;
endmodule

