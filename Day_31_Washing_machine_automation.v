/////////////////////////////////////////Design Block//////////////////////////////////
module washing_machine_automation (clk, rst, start, door_close, door_lock, water_filled, fill_valve_on, 
                                   detergent_added, water_wash, cycle_time_out, motor_on, drained, drained_valve_on, spin_time_out, done);
input start, door_close, water_filled, detergent_added, cycle_time_out, drained, spin_time_out, water_wash, clk,rst;
output reg door_lock, fill_valve_on, motor_on, drained_valve_on, done;
localparam check_door = 3'b000,
           fill_water = 3'b001,
			  add_detergent = 3'b010,
			  cycle = 3'b011,
			  drain_water = 3'b100,
			  spin = 3'b101;
reg [2:0] present_state, next_state;
initial
begin
present_state = check_door;
next_state = check_door;
door_lock = 0;
fill_valve_on = 0;
motor_on = 0;
drained_valve_on = 0;
done = 0;
end
always @(posedge clk,posedge rst)
begin
if (rst)
present_state = check_door;
else 
present_state = next_state;
end
always @(present_state, start, door_close, water_filled, 
detergent_added, cycle_time_out, drained, spin_time_out, water_wash)
case (present_state)
check_door : if (start == 1 & door_close == 1)
				 begin
				 door_lock = 1;
				 next_state = fill_water;
				 end
				 else 
				 begin
		       next_state = check_door;
				 door_lock = 0;
				 end
fill_water : if(water_filled == 0 &  water_wash == 0)
				 fill_valve_on = 1;
				 else if (water_filled == 1 & water_wash == 0)
				 begin
				 next_state = add_detergent;
				 fill_valve_on = 0;
				 end
				 else if (water_filled == 1 & water_wash == 1)
				 begin
				 next_state = cycle;
				 fill_valve_on = 0;
				 end
add_detergent:if (detergent_added == 1)
				 begin
				 next_state = cycle;
				 end
cycle :      if (cycle_time_out == 0 )
				 motor_on = 1;
				 else if (cycle_time_out == 1)
				 begin
				 motor_on = 0;
				 next_state = drain_water;
				 end
drain_water :if (drained == 0 & water_wash == 0)
				 drained_valve_on = 1;
				 else if (drained == 0 & water_wash == 1)
				 begin
				 next_state = fill_water;
				 fill_valve_on = 1;
				 end
				 else if (drained == 1 )
				 begin
				 next_state = spin;
				 drained_valve_on = 0;
				 end
spin:        if (spin_time_out == 0)
				 done = 0;
				 else if (spin_time_out == 1)
				 begin
				 next_state = check_door;
				 done = 1;
				 end
endcase				 				 
endmodule
///////////////////////////////////Test bench//////////////////////////////////////
`timescale 1ns/1ps
module washing_machine_testbench();
reg start, door_close, water_filled, detergent_added, cycle_time_out, drained, spin_time_out, water_wash, clk,rst;
wire door_lock, fill_valve_on, motor_on, drained_valve_on, done;
washing_machine_automation wma(clk, rst, start, door_close, door_lock, water_filled, fill_valve_on, 
                                   detergent_added, water_wash, cycle_time_out, motor_on, drained, drained_valve_on, spin_time_out, done);
initial
begin
clk = 0;
forever #1 clk = ~clk;
end
initial
begin
start = 0; rst = 0; door_close =0;
#5 start = 1; door_close =1; water_filled = 0;water_wash = 0; #5 water_filled = 1;water_wash = 0; detergent_added = 0; #5 detergent_added = 1;
      cycle_time_out=0; #5 cycle_time_out=1; drained = 0; #5 drained = 1; spin_time_out =0; #5 spin_time_out =1; start =0;

end
initial 
#60 $stop;
initial
$monitor ("time = ",$time ,",door_lock = %b, fill_valve_on = %b, motor_on = %b, drained_valve_on = %b, done = %b ",door_lock,fill_valve_on,motor_on,drained_valve_on,done);
endmodule 
