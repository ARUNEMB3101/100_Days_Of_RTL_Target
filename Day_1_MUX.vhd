-----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity problem_Statement_1 is
port ( a,b : in std_logic_vector(7 downto 0);
sel : in std_logic_vector(1 downto 0);
c : out std_logic_vector(7 downto 0));
end problem_Statement_1;
------------------------------------------
architecture mux of problem_statement_1 is 
begin
process(a,b,sel)
begin 
if( sel = "00") then
 c <= "00000000";
elsif(sel = "01") then
 c <= a;
elsif(sel = "10") then
 c <= b;
else
  c <= (others => '0');
end if;
end process;
end mux;
------------------------------------------
