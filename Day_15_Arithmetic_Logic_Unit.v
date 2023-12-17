////////////////////////////Design_Block///////////////////////////
`timescale 1ns / 1ps
module Artihmetic_and_Logical_Unit(out,a,b,select);
input [3:0] a, b;
input [2:0] select;
output reg [4:0] out;
always @(a,b,select)
case (select)
3'b000: out = a;
3'b001: out = a+b;
3'b010: out = a-b;
3'b011: out = a/b;
3'b100: out = a%b;
3'b101: out = a<<1;
3'b110: out = a>>1;
3'b111: out = (a>b);
endcase
endmodule

