///////////DESIGN_BLOCK//////////////////////////
module mux_4_1(out, i0, i1, i2, i3, s1,s0);
output out;
input i0,i1,i2,i3,s1,s0;
wire s0n,s1n;
wire y0,y1,y2,y3;
not (s1n,s1);
not (s0n,s0);
and (y0,i0,s1n,s0n);
and (y1,i1,s1n,s0);
and (y2,i2,s1,s0n);
and (y3,i3,s1,s0);
or (out,y0,y1,y2,y3);
endmodule

///////////////TEST_BENCH/////////////////////////

module testbench();
reg in0,in1,in2,in3;
reg s1,s0;
wire out;
mux_4_1 mymux(out,in0,in1,in2,in3,s1,s0);
initial
begin 
in0=1;in1=0;in2=1;in3=0;
#1 $display("ino= %b, in1= %b ,in2 =%b, in3= %b \n",in0,in1,in2,in3);
s1=0;s0=0;
#1 $display("s1= %b, s0 =%b, OUTPUT = %b \n",s1,s0,out);
s1=0;s0=1;
#1 $display("s1= %b, s0 =%b, OUTPUT = %b \n",s1,s0,out);
s1=1;s0=0;
#1 $display("s1= %b, s0 =%b, OUTPUT = %b \n",s1,s0,out);
s1=1;s0=1;
#1 $display("s1= %b, s0 =%b, OUTPUT = %b \n",s1,s0,out);
end
endmodule
