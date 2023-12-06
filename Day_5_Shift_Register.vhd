library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity shift_registers is 
generic ( n: integer :=4);
port( d, clk,rst : in std_logic;
      q : out std_logic);
end shift_registers;
------------------------------------
architecture behaviour of shift_registers is
 signal internal : std_logic_vector ( n-1 downto 0);
begin 
 process ( clk, rst)
 begin 
 if ( rst = '1')then
 internal <= (others => '0');
 elsif (clk'event and clk ='1') then
 internal <= d & internal(internal'LEFt downto 1);
 end if ;
 end process;
 q <= internal(0);
 end behaviour;
------------------------------------
