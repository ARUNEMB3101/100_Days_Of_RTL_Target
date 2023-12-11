///////////////////////////FULL_SUBTRACTOR _ DESIGN BLOCK//////////////////////////
`timescale 1ns / 1ps
module Full_Subtractor(D,B,x,y,z);
input x,y,z;
output D,B;
assign D = (~x&~y&z)|(x&~y&~z)|(x&y&z),
B = (~x&y)|(~x&z)|(y&z);
endmodule

///////////////////////////////TEST_BENCH FOR FULL SUBTRACTOR/////////////////////////////////
module Full_Subtractor_testbench();
reg x,y,z;
wire D,B;
Full_Subtractor fb(D,B,x,y,z);
initial
begin
$monitor($time," x=%b, y=%b ,z=%b,D=%b, B=%b",x,y,z,D,B);
end
initial
begin 
 #1x=0;y=0;z=0;
 #5x=0;y=0;z=1;
 #5x=0;y=1;z=0;
 #5x=0;y=1;z=1;
 #5x=1;y=0;z=0;
 #5x=1;y=0;z=1;
 #5x=1;y=1;z=0;
 #5x=1;y=1;z=1;
 end 
 endmodule
