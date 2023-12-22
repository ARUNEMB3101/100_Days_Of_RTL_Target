/////////////////////////////////////////Design_Block///////////////////
`timescale 1ns / 1ps
`define size 16
module Data_buffer(data_start, data, clock);
parameter cycles=8;
input data_start,clock;
input [`size-1:0]data;
reg [`size-1:0]buffer[0:cycles-1];
integer i=0;
always @(posedge clock)
case (data_start)
1'b1: begin
repeat(cycles)
begin
@(posedge clock) buffer[i]=data;
i=i+1;
end
end
1'b0:begin
end
endcase
endmodule
