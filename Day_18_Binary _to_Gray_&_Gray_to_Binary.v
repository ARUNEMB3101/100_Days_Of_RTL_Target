/////////////////Design_Block_Binary_to_Gray///////////////////////
`timescale 1ns / 1ps
`define size 3
module Binary_to_Gray_convertor(g,b);
input [`size:0] b;
output [`size:0] g;
assign g[3] = b[3];
assign g[2] = b[3]^b[2];
assign g[1] = b[2]^b[1];
assign g[0] = b[1]^b[0];
endmodule

/////////////////Design_Block_Gray_to_Binary///////////////////////
`timescale 1ns / 1ps
`define size 3
module Gray_to_Binary_Convertor(b,g);
input [`size:0] g;
output [`size:0] b;
assign b[3] = g[3];
assign b[2] = b[3]^g[2];
assign b[1] = b[2]^g[1];
assign b[0] = b[1]^g[0]; 
endmodule
