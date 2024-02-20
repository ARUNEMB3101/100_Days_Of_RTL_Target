///////////////////////////////Design Block////////////////////////
module vending_machine_woc(out, in_price, clk, rst);
input clk, rst;
input [1:0] in_price;
output reg out = 0;
reg [1:0]prst_st = 2'b0, nxt_st = 2'b0;
localparam ten_rupee = 2'b10,
           five_rupee = 2'b01,
			  zero_rupee = 2'b00,
			  S0 = 2'b00,
			  S1 = 2'b01,
			  S2 = 2'b10;
always @(posedge clk)
  begin
   if (rst)
     begin
	  prst_st = S0;
	  end
	else 
	  begin
	  prst_st = nxt_st;
	  end
	end
always @(prst_st, in_price)
  begin
  case (prst_st)
    S0: if(in_price == zero_rupee)
	     begin
		  out = 0;
		  end
		  else if (in_price == ten_rupee)
		  begin
		  nxt_st = S2;
		  out = 0;
		  end
		  else if (in_price == five_rupee)
		  begin
		  nxt_st = S1;
		  out = 0;
		  end
	 S1: if (in_price == zero_rupee)
	     begin
		  out = 0;
		  nxt_st = prst_st;
		  end
		  else if (in_price == five_rupee)
		  begin
		  out = 0;
		  nxt_st = S2;
		  end
		  else if (in_price == ten_rupee)
		  begin
		  out = 1;
		  nxt_st = S0;
		  end
	 S2: if (in_price == ten_rupee | in_price == five_rupee )
	     begin
		  out = 1;
		  nxt_st = S0;
		  end
		  else if (in_price == zero_rupee)
		  begin
		  out = 0;
		  nxt_st = S0;
		  end
  endcase
  end
endmodule
////////////////////////////Test bench////////////////////////////////////
`timescale 1ns/1ps
module vending_machine_woc_tb();
wire out;
reg clk, rst;
reg [1:0] in_price;
localparam ten_rupee = 2'b10,
           five_rupee = 2'b01,
			  zero_rupee = 2'b00;
vending_machine_woc vm(.out(out), .rst(rst), .clk(clk), .in_price(in_price));
initial
begin
clk = 0;
rst =0;
forever #5 clk = ~clk;
end
initial
begin
#10 in_price = ten_rupee;
#5 in_price = ten_rupee;
#5 in_price = zero_rupee;
#5 in_price = five_rupee;
#5 in_price = five_rupee;
#5 in_price = five_rupee;
#5 in_price = five_rupee;
#5 in_price = zero_rupee;
#5 in_price = ten_rupee;
#5 in_price = five_rupee;
end
initial
$monitor ("Reset = %b, in_price = %b, out = %b", rst, in_price, out);
initial
#100 $finish;
endmodule
