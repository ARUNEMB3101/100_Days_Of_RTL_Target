library ieee;
use ieee.std_logic_1164.all;
--------------------------------
entity ripple_carry_adder is 
port ( a : in std_logic_vector(7 downto 0);
       b : in std_logic_vector(7 downto 0);
       cout : out std_logic;
       sum : out std_logic_vector(7 downto 0);
       cin : in std_logic 
);
end ripple_carry_adder;
architecture adder of ripple_carry_adder is 
begin
process ( a, b, cin)
variable carry : std_logic_vector(8 downto 0);
begin
   carry(0) := cin;
calculate: for i in 0 to 7 Loop
  sum(i) <= a(i) xor b(i) xor carry(i);
  carry(i+1) := (a(i) and b(i)) or (a(i) and carry(i)) or (b(i) and carry(i));
  end loop calculate;
cout <= carry(8);
end process;
end adder; 
