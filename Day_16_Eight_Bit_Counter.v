///////////////////Design_block////////////////////////
module Eight_bit_counter(clck,count);
input clck;
output reg [7:0] count = 8'd5;
always @(posedge clck)
begin : block
if(count != 8'd64)
   count <= count+1;
else
   disable block;
end
endmodule

/////////////////////Test_Bench///////////////////////////
`timescale 1ns / 1ps
module Eight_bit_counter_testbench();
reg clck;
wire [7:0] count;
Eight_bit_counter ebc(clck,count);
initial 
begin
clck = 1'b0;
forever #5 clck = ~clck;
end
endmodule
