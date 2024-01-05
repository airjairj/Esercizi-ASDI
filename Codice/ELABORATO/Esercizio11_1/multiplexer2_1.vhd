library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1 is
	port( 	a0 	: in std_logic_vector(1 downto 0);
			a1 	: in std_logic_vector(1 downto 0);
			s 	: in STD_LOGIC;
			y 	: out std_logic_vector(1 downto 0)
	);
end mux_2_1;


architecture dataflow of mux_2_1 is

	begin
		y <= a0 when s='0' else
		     a1 when s='1';

end dataflow;


