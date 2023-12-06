-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
-----------------------------------
entity ram_memory is 
generic (
   bits : integer := 8;
   words : integer := 16 );
port (
   data_in : in std_logic_vector(bits-1 downto 0);
   data_out : out std_logic_vector(bits-1 downto 0);
   wr_ena,clk : in bit ;
   addr : in integer range 0 to words-1
);
end ram_memory;
architecture ram_memory of ram_memory is 
type vector_memory is array(0 to words-1) of std_logic_vector(bits-1 downto 0);
signal memory : vector_memory;
begin
process (clk,wr_ena)
begin
case wr_ena is 
  when '1' => memory(addr) <= data_in;
  when others => null;
end case;
end process;
data_out <= memory(addr);
end architecture;
