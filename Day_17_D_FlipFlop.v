//////////////////////Design_Block/////////////////
`timescale 1ns / 1ps
module D_FlipFlop(q,qbar,clear,d_in,clock);
input d_in,clock,clear;
output reg q,qbar;
always @(negedge clock)
begin
if (clear != 1'b1)
begin
      q <= d_in;
      qbar <= ~d_in;
end
else
begin
       q <= 0;
       qbar <= 1;
end
end
endmodule
////////////////////////Test_bench////////////////////////
`timescale 1ns / 1ps
module D_FlipFlop_verification();
reg clck,d_in,clear;
wire q,qbar;
D_FlipFlop dff(q,qbar,clear,d_in,clck);
initial
begin
clck = 1'b0;
 forever #5 clck = ~clck;
 end
 initial
 begin
 #5 d_in = 1'b1; ;clear = 1'b0;
 #10 d_in = 1'b0; clear = 1'b0;
 #10 clear = 1'b1; d_in = 1'b0;
end
initial 
#100 $finish;
endmodule

