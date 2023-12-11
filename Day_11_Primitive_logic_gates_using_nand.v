/////////////////////MY_AND_DESIGN_BLOCK/////////////////////////
module my_and(out,a,b);
input a,b;
output out;
wire s1;
nand(s1,a,b);
nand(out,s1,s1);
endmodule
//////////////////////MY_NOT_DESIGN_BLOCK////////////////////////
module my_not(out,a);
input a;
output out;
nand(out,a,a);
endmodule
///////////////////////////MY_OR_DESIGN_BLOCK//////////////////////////
module my_or(out,a,b);
input a,b;
output out;
wire s1,s2;
nand(s1,a,a);
nand(s2,b,b);
nand(out,s1,s2);
endmodule
/////////////////////TEST_BENCH_FOR_PRIMITIVE_GATES_BY NAND///////////////////////////
module my_and_testbench();
reg a,b;
wire out;
//my_and and1(out,a,b);
//my_or or1(out,a,b);
my_not not1(out,a);
initial
begin
$monitor($time," a=%b, b=%b ,out=%b",a,b,out);
end
initial
begin 
 #1a=1;b=1;
 #10 a=0;b=1;
 #10 a=1;b=0;
 #10 a=0;b=0;
 end 
 endmodule
