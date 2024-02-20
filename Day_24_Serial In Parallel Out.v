/////////////////////D FLIFLOP///////////////////////////////////
module D_Flip_Flop(q_out,clk,d_in);
input d_in,clk;
output reg q_out;
initial
q_out = 0;
always @(posedge clk)
     q_out <= d_in;
endmodule
/////////////////////DESIGN BLOCK ////////////////////////////
module Serial_In_Serial_Out(q,data_in,clk);
input data_in;
input clk;
output [3:0]q;
D_Flip_Flop da_ff1(q[0],clk,data_in);
D_Flip_Flop db_ff2(q[1],clk,q[0]);
D_Flip_Flop dc_ff3(q[2],clk,q[1]);
D_Flip_Flop dd_ff4(q[3],clk,q[2]);
endmodule
/////////////////////////TESTBENCH/////////////////////////////
`timescale 1ns/1ps
module Serial_In_Serial_out_testbench();
reg clk,data_in;
wire [3:0]q_out;
Serial_In_Serial_Out sipo(q_out,data_in,clk);
initial 
begin
clk = 1'b0;
forever #3 clk = ~clk;
end
initial 
begin
 @(posedge clk) data_in = 1'b1;
 @(posedge clk) data_in = 1'b1;
 @(posedge clk) data_in = 1'b1;
 @(posedge clk) data_in = 1'b0;
end
initial
#50 $stop;
endmodule

 
