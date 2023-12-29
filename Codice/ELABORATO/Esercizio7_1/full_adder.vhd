library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is 
	port(
	a,b: in std_logic; 
	cin: in std_logic;
	cout, s: out std_logic);
end full_adder;


architecture rtl of full_adder is

	begin
	
	s<= a xor b xor cin;
	cout<= (a and b) or (cin and (a xor b));
	
	end rtl;