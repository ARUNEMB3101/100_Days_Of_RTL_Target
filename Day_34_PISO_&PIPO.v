///////////////////////////Design of 2:1 mux////////////////////////////////
module mux_2to1(out, d0, d1, sel);
input d0,d1, sel;
output out;
assign out = sel ? d1 : d0;
endmodule 
/////////////////////Design of d_flipflop//////////////////////////////////
module d_flipflop(q, d_in, clk);
input clk, d_in;
output reg q;
always @(posedge clk)
begin
 q <= d_in;
end
endmodule
///////////////////Design of piso/////////////////////////////////
module piso(q3, d0, d1, d2, d3, clk, sh_lo);
input d0, d1, d2, d3, clk, sh_lo;
output q3;
wire q0, q1, q2, m1, m2, m3;
d_flipflop dff1(q0, d0, clk);
mux_2to1 mx1(m1, d1, q0, sh_lo);
d_flipflop dff2(q1, m1, clk);
mux_2to1 mx2(m2, d2, q1, sh_lo);
d_flipflop dff3(q2, m2, clk);
mux_2to1 mx3(m3, d3, q2, sh_lo);
d_flipflop dff4(q3, m3, clk);
endmodule
///////////////////Desgin of pipo///////////////////////////////
`timescale 1ns / 1ps
module pipo(qa, qb, qc, qd, da, db, dc, dd, clk);
output qa, qb,qc,qd;
input da, db, dc, dd, clk;
d_flipflop dff1(qa, da, clk);
d_flipflop dff2(qb, db, clk);
d_flipflop dff3(qc, dc, clk);
d_flipflop dff4(qd, dd, clk);
endmodule
