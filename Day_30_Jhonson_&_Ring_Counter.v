//////////////////D_Flipflop////////////////////////
module D_Flip_Flop(q_out,q_bar,clk,d_in);
input d_in,clk;
output reg q_out,q_bar;
initial
begin
q_out = 0;
q_bar = 1;
end
always @(posedge clk)
begin
     q_out <= d_in;
	  q_bar <= ~d_in;
end
endmodule
//////////////Design of Jhonson Counter///////////////////////
module Jhonson_counter(q,clk);
input clk;
output [3:0]q;
wire [3:0]q_b;
D_Flip_Flop da_ff1(q[0],q_b[0],clk,q_b[3]);
D_Flip_Flop da_ff2(q[1],q_b[1],clk,q[0]);
D_Flip_Flop da_ff3(q[2],q_b[2],clk,q[1]);
D_Flip_Flop da_ff4(q[3],q_b[3],clk,q[2]);
endmodule
////////////Test bench for jhonson Counter//////////////////////
`timescale 1ns/100ps
module jhonson_counter_tb();
reg clk;
wire [3:0]q;
Jhonson_counter jc(.clk(clk),.q(q));
initial
 clk =0;
 always 
 #2 clk =~clk;
initial
#50 $stop;
endmodule
///////////////////Design of Ring counter/////////////////////////
module Ring_counter(ring_out,clk);
output [3:0] ring_out;
input clk;
reg [3:0] temp_out = 0001;
always @(posedge clk)
begin
temp_out[3] <= temp_out[0];
temp_out[2] <= temp_out[3];
temp_out[1] <= temp_out[2];
temp_out[0] <= temp_out[1];
end
assign ring_out = temp_out;
endmodule
//////////////////test bench for ring counter////////////////////////////
`timescale 1ns/100ps
module ring_counter_tb();
reg clk;
wire [3:0]ring_out;
Ring_counter rc(ring_out,clk);
initial
begin
clk = 0;
forever #2 clk = ~clk;
end
initial
#50 $stop;
endmodule
