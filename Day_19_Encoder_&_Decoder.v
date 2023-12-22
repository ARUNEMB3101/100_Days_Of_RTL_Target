//////////////////Encoder_8:3_Design_Block/////////////////////////////
`timescale 1ns / 1ps
module Encoder_8_3(out,in);
input [7:0]in;
output [2:0]out;
assign out[0] = in[4]+in[5]+in[6]+in[7];
assign out[1] = in[2]+in[3]+in[6]+in[7];
assign out[2] = in[1]+in[3]+in[5]+in[7];
endmodule

//////////////////Decoder_3:8_Design_Block/////////////////////////////
`timescale 1ns / 1ps
module Decoder_3_8(out,in);
input [2:0]in;
output [7:0]out;
assign out[7] =  in[2]&in[1]&in[0];
assign out[6] =  in[2]&in[1]&~in[0];
assign out[5] =  in[2]&~in[1]&in[0];
assign out[4] =  in[2]&~in[1]&~in[0];
assign out[3] = ~in[2]&in[1]&in[0];
assign out[2] = ~in[2]&in[1]&~in[0];
assign out[1] = ~in[2]&~in[1]&in[0];
assign out[0] = ~in[2]&~in[1]&~in[0];
endmodule
