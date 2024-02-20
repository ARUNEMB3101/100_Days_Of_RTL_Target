//////////////////////////////Design of I2C Master///////////////////////////////////
`timescale 1ns / 1ps
module I2C_Master(scl, sda, en, data_wr, addr, rw, clk);
input  en, rw, clk;
output scl;
inout trior sda = 1'b1;
reg ack = 0;
input [7:0]data_wr;
reg [7:0]data_r = 8'b0;
input [6:0]addr;
integer counta=0, countd=0;
reg sd = 1'b1;
localparam IDLE = 3'b000,
           START = 3'b001,
           ADDR = 3'b010,
           ACK1 = 3'b011,
           READ = 3'b100,
           WRITE = 3'b101,
           ACK2 = 3'b110,
           STOP = 3'b111;
reg [2:0]nxt_state, prst_state;
clock_divider_2 cld(.out(scl), .clk(clk));
I2C_Slave slv(sda, scl);
assign sda =sd;
initial
begin
nxt_state = 3'b000;
prst_state = 3'b000;
end
always @(posedge clk)
begin
prst_state = nxt_state;
end
always @(prst_state,en)
begin
 case(prst_state)
     IDLE : begin
            if (en == 1)
            begin
            sd = 1'b1;
            nxt_state = START;
            end
            else
            begin
            sd = 1'b1;
            nxt_state = IDLE;
            end
            end
    START : begin
            if (en == 1)
            begin
            @ (posedge scl);
            #10 sd = 1'b0;
            nxt_state = ADDR;
            end
            else
            begin 
            nxt_state = IDLE;
            end
            end
    ADDR  : begin
            for(counta =6;counta >= 0; counta = counta - 1)
            begin
            @(negedge scl);
            sd = addr[counta];
            end
            @(negedge scl);
             sd = rw;
            nxt_state = ACK1;
            end
     ACK1 : begin
            @(negedge scl);
            sd = 1'b0;
            #2 ack = sda;
            if(ack == 0) 
            begin 
             if (rw ==  0)//represents write mode
             begin
             nxt_state = WRITE;
             end
             else // else rw = 1 represents read mode
             begin
             nxt_state = READ;
             end
            end
            else
            begin
             nxt_state = STOP;
            end
            end
     READ: begin
           for (countd = 0;countd <=7;countd = countd +1) 
           begin
            @(negedge scl);
            data_r[countd]= sda;
            end
            $display("data_read = %b", data_r);
            nxt_state = ACK2;
           end
    WRITE: begin
             for (countd = 0;countd <=7;countd = countd +1) 
             begin
             @(negedge scl);
             sd = data_wr[countd];
              end
              nxt_state = ACK2;
              end
      ACK2: begin
              if(rw == 1)
              begin
              @(negedge scl);
              sd = 1'b0;
              nxt_state = STOP;
              end
              else if (rw == 0)
              begin
              @(negedge scl);
              nxt_state = STOP;
              end
            end
       STOP:  begin
              @ (posedge scl); // sending stop signal
               #2 sd = 1'b1;
              if (en == 1)
              begin
              sd = 1'b1;
              nxt_state = START;
              end
              else
              begin
              sd = 1'b1;
              nxt_state = IDLE;
              end
              end
      endcase   
end
endmodule         

////////////////////////////////Design of I2C slave /////////////////////////////////////////
`timescale 1ns / 1ps
module I2C_Slave(sda, scl);
input scl;
inout trior sda= 1'b0;
reg sd = 1'b0;
reg [7:0] data_read = 8'b0;
reg [7:0] data_write = 8'b00101010;
reg [6:0] my_adr = 7'b0001110;
reg [6:0] rv_adr = 7'b0;
reg rw = 0;
reg ack = 0;
reg nack = 1;
reg [2:0]nxt_st, prst_st;
integer counta,countd;
localparam START = 3'b000,
           ADDR = 3'b001,
           READ = 3'b010,
           WRITE = 3'b011,
           STOP = 3'b100;
assign sda =sd;
initial
begin
prst_st = 3'b001;
nxt_st = 3'b000;
end
always @(posedge scl)
begin
  if (scl)
    begin
    prst_st = nxt_st;
    end
   else
    begin
    prst_st = prst_st;
    end
end
always @(prst_st)
begin
case(prst_st)
START : begin
        while(scl != 1'b1 & sda == 1'b0)
        begin
        end
        nxt_st = ADDR;
        end
ADDR  : begin
        for(counta =7;counta >= 0; counta = counta - 1)
            begin
            @(negedge scl);
            #5 rv_adr[counta] = sda;
            end
            $display("addr = %b",rv_adr);
            @(negedge scl);
            if(rv_adr == my_adr)
            begin
            @(negedge scl);
            sd = ack; //addressed was matched and sending positive acknowledgement
            end
            else
            begin
            @(negedge scl);
            sd = nack; //addressed was not matched and sending negative acknowledgement
            end
            if(rw == 1'b0)
            begin
            nxt_st = READ;
            end
            else
            begin
            nxt_st = WRITE;
            end
          end
 READ   : begin
         $display("Inside slave read block");
          for(countd =0;countd <= 7; countd = countd + 1)
             begin
             @(negedge scl);
             data_read[countd] = sda;
             end
             @(negedge scl);
             sd = ack; // data received and acknowledged;
          end
 WRITE  : begin
          $display("Inside slave Write block");
          for(countd =0;countd <= 7; countd = countd + 1)
             begin
             @(negedge scl);
             $display("Data = %b",data_write[countd]);
             sd = data_write[countd];
             end
             @(negedge scl); //this is for receving acknowledgement signal
             nxt_st = STOP;
          end 
 STOP   : begin
            if (sda == 1'b0)
            begin
            while(scl != 1'b1 & sda == 1'b1)
            begin
            end
            nxt_st = START;              
            end
            else
            begin
            while(scl != 1'b1 & sda == 1'b1)
            begin
            end
            nxt_st = START;
            end 
          end           
endcase
end
endmodule
/////////////////////////////////Design of clock divider//////////////////////////////////////////
`timescale 1ns / 1ps
module clock_divider_2(out, clk);
input clk;
reg t =1'b1;
output reg out = 0;
always @(posedge clk)
 out <= t?~out:t;
endmodule
