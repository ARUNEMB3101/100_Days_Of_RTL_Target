/////////////////////////////////DESIGN BLOCK /////////////////////////////
`timescale 1ns / 1ps
module SR_Latch( q,qbar, sbar,rbar);
input sbar,rbar;
output q,qbar;
nor n1(q,qbar,sbar);
nor n2(qbar,q,rbar);
endmodule

////////////////////////////////TESTBENCH BLCOK/////////////////////////////
module SR_Latch_testbench();
reg set,reset;
wire q,qbar;
SR_Latch sr(q,qbar,set,reset);
initial
begin
$monitor($time, "set = %b,reset =%b,q = %b, qbar = %b",set,reset,q,qbar);
end 
initial
begin
set=1'b0;reset=1'b1;
 #5 set=1'b1;reset=1'b0;
 #5 set=1'b1;reset=1'b1;
 #5 set=1'b1;reset=1'b1;
 end
 endmodule
