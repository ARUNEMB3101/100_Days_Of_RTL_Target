library ieee;
use ieee.std_logic_1164.all;
---------------------------------
Entity simple_barrel_shifter is 
port ( inp : in std_logic_vector(7 downto 0);
       outp : out std_logic_vector( 7 downto 0);
       shift : in bit 
);
end simple_barrel_shifter;
architecture shifter of simple_barrel_shifter is 
begin 
process ( shift ,inp )
begin
case shift is
  when '1' => outp(0) <= '0';
   for i in 0 to 6 loop
   outp(i+1) <= inp(i);
   end loop;
   when '0' => outp <= inp;
end case;  
end process;            
end architecture;
