module NO_SD_1001(
   input in,
	input clck,
	input rst,
	output reg out);
reg [1:0]prst_st, nxt_st;
localparam A = 2'b00,
           B = 2'b01,
			  C = 2'b10,
			  D = 2'b11;
initial 
begin
prst_st = 2'b00;
nxt_st = 2'b00;
end
always @(posedge clck, posedge rst)
begin
if (rst)
prst_st = A;
else 
prst_st = nxt_st;
end
always @(prst_st , in)
case (prst_st)
 A: if(in == 0)
    begin
	 out = 0;
	 nxt_st = A;
	 end
	 else if (in == 1)
	 begin
	 out = 0;
	 nxt_st = B;
	 end
 B: if(in == 0)
    begin
	 out = 0;
	 nxt_st = C;
	 end
	 else if (in == 1)
	 begin
	 out = 0;
	 nxt_st = B;
	 end
 C: if(in == 0)
    begin
	 out = 0;
	 nxt_st = D;
	 end
	 else if (in == 1)
	 begin
	 out = 0;
	 nxt_st = B;
	 end
 D: if(in == 0)
    begin
	 out = 0;
	 nxt_st = A;
	 end
	 else if (in == 1)
	 begin
	 out = 1;
	 nxt_st = A;
	 end
endcase
endmodule

