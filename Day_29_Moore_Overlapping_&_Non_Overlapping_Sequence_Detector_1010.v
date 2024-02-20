///////////////////////////design of non-overlapping sequence detector 1010//////////////////////////////////
module NOL_SD_Moore_101(out, inp, rst, clck);
input inp,clck,rst;
output out;
reg[2:0] prst_state, nxt_state;
reg out;
localparam A = 3'b000,
           B = 3'b001,
			  C = 3'b010,
			  D = 3'b011,
			  E = 3'b100;
initial
begin
prst_state = 3'b000;
nxt_state = 3'b000;
end
always @(posedge clck, posedge rst)
begin
if (rst)
prst_state = A;
else
prst_state = nxt_state;
end
always @(prst_state, inp)
begin
if (prst_state == A & inp == 0)
begin
nxt_state = A;
out = 0;
end
else if (prst_state == B & inp == 1)
begin
nxt_state = B;
out = 0;
end
if (prst_state == B & inp == 1)
begin
nxt_state = B;
out = 0;
end
else if (prst_state == B & inp == 0)
begin
nxt_state = C;
out =0;
end
if (prst_state == C & inp == 0)
begin
nxt_state = A;
out = 0;
end
else if (prst_state == C & inp == 1)
begin
nxt_state = D;
out = 0;
end
if (prst_state == D & inp == 1)
begin
nxt_state = B;
out = 0;
end
else if (prst_state == D & inp == 0)
begin
nxt_state = E;
out = 1;
end
if(prst_state == E & inp == 1)
begin
nxt_state = B;
out = 0;
end
else if (prst_state == E & inp == 0)
begin
nxt_state = A;
out = 0;
end
end
endmodule
///////////////////////////design of overlapping sequence detector 1010//////////////////////////////////
module OL_Moore_SD_1010(out, inp, rst, clck);
input inp,clck,rst;
output out;
reg[2:0] prst_state, nxt_state;
reg out;
localparam A = 3'b000,
           B = 3'b001,
			  C = 3'b010,
			  D = 3'b011,
			  E = 3'b100;
initial
begin
prst_state = 3'b000;
nxt_state = 3'b000;
end
always @(posedge clck, posedge rst)
begin
if (rst)
prst_state = A;
else
prst_state = nxt_state;
end
always @(prst_state, inp)
begin
if (prst_state == A & inp == 0)
begin
nxt_state = A;
out = 0;
end
else if (prst_state == A & inp == 1)
begin
nxt_state = B;
out = 0;
end
if (prst_state == B & inp == 1)
begin
nxt_state = B;
out = 0;
end
else if (prst_state == B & inp == 0)
begin
nxt_state = C;
out =0;
end
if (prst_state == C & inp == 0)
begin
nxt_state = A;
out = 0;
end
else if (prst_state == C & inp == 1)
begin
nxt_state = D;
out = 0;
end
if (prst_state == D & inp == 1)
begin
nxt_state = B;
out = 0;
end
else if (prst_state == D & inp == 0)
begin
nxt_state = E;
out = 1;
end
if(prst_state == E & inp == 1)
begin
nxt_state = D;
out = 0;
end
else if (prst_state == E & inp == 0)
begin
nxt_state = A;
out = 0;
end
end
endmodule
