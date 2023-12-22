////////////////////////////////Main_Block/////////////////////
`timescale 1ns / 1ps
module Simple_Barrel_Shifter(out,in,sh_pos);
input [7:0]in;
output [7:0]out;
input [2:0]sh_pos;
wire [7:0]out0,out1;
//////////Stage-0 Begins//////////////////////////////
mux_2_1 m00(.out(out0[0]),.s(sh_pos[0]),.in0(0),.in1(in[0]));
mux_2_1 m01(.out(out0[1]),.s(sh_pos[0]),.in0(in[0]),.in1(in[1]));
mux_2_1 m02(.out(out0[2]),.s(sh_pos[0]),.in0(in[1]),.in1(in[2]));
mux_2_1 m03(.out(out0[3]),.s(sh_pos[0]),.in0(in[2]),.in1(in[3]));
mux_2_1 m04(out0[4],sh_pos[0],in[3],in[4]);
mux_2_1 m05(out0[5],sh_pos[0],in[4],in[5]);
mux_2_1 m06(out0[6],sh_pos[0],in[5],in[6]);
mux_2_1 m07(out0[7],sh_pos[0],in[6],in[7]);
//////////Stage-1 Begins///////////////////////////////
mux_2_1 m10(out1[0],sh_pos[1],0,out0[0]);
mux_2_1 m11(out1[1],sh_pos[1],0,out0[1]);
mux_2_1 m12(out1[2],sh_pos[1],out0[0],out0[2]);
mux_2_1 m13(out1[3],sh_pos[1],out0[1],out0[3]);
mux_2_1 m14(out1[4],sh_pos[1],out0[2],out0[4]);
mux_2_1 m15(out1[5],sh_pos[1],out0[3],out0[5]);
mux_2_1 m16(out1[6],sh_pos[1],out0[4],out0[6]);
mux_2_1 m17(out1[7],sh_pos[1],out0[5],out0[7]);
/////////Stage-2 Begins////////////////////////////////
mux_2_1 m20(out[0],sh_pos[2],0,out1[0]);
mux_2_1 m21(out[1],sh_pos[2],0,out1[1]);
mux_2_1 m22(out[2],sh_pos[2],0,out1[2]);
mux_2_1 m23(out[3],sh_pos[2],0,out1[3]);
mux_2_1 m24(out[4],sh_pos[2],out1[0],out1[4]);
mux_2_1 m25(out[5],sh_pos[2],out1[1],out1[5]);
mux_2_1 m26(out[6],sh_pos[2],out1[2],out1[6]);
mux_2_1 m27(out[7],sh_pos[2],out1[3],out1[7]);
endmodule


//////////////////////Design_block_Mux_2:1/////////////////////////
`timescale 1ns / 1ps
module mux_2_1(out,s,in0,in1);
input in1,in0,s;
output out;
 assign out = ~s? in1:in0;
endmodule
