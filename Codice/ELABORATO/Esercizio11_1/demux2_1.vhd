library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demux1_2 is port( 
	a	: in STD_LOGIC_VECTOR(1 downto 0);
	sel : in std_logic;
	y1	: out STD_LOGIC_VECTOR(1 downto 0);
	y2	: out STD_LOGIC_VECTOR(1 downto 0)	
	);
		
end demux1_2;


architecture struttura of demux1_2 is

	begin
	
	y1 <= a when sel='0' else "00";
    y2 <= a when sel='1' else "00";
	
	
end struttura;


