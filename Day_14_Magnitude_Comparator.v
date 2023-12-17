//////////////////////Design_Block//////////////////////
`timescale 1ns / 1ps
module Magnitude_Comparator(AltB,AgtB,AeqB,A,B);
input [2:0] A,B;
output AltB,AgtB,AeqB;
assign AltB = (A<B);
assign AeqB = (A==B);
assign AgtB = (A>B);
endmodule

////////////////////////////////Test_bench//////////////////////////////
`timescale 1ns / 1ps
module Magnitude_Comparator_Testbench();
reg [2:0] A,B;
wire AltB,AgtB,AeqB;
Magnitude_Comparator mg(AltB,AgtB,AeqB,A,B);
initial
begin
 A=3'd4;B=3'd2;
 #5 A=3'd2;B=3'd2;
 #5 A=3'd6;B=3'd7;
end
endmodule
