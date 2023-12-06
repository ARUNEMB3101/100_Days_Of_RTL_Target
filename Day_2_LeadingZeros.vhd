library ieee;
use ieee.std_logic_1164.all;
----------------------------------
Entity leading_zeros is 
port (
      input : in std_logic_vector(7 downto 0);
      zeros : out integer range 0 to 8
);
end leading_zeros;
architecture leading_zeros of leading_zeros is 
begin 
process ( input)
variable count : integer range 0 to 8 ;
begin
  count := 0;
  for i in input'range 
loop
  case input(i) is
    when '0' => count := count+1;
    when others => Exit;
  end case;
end loop;
zeros <= count;
end process;
end architecture;
  
