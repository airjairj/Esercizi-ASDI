library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo demux_1_4.
entity demux_1_4 is 
	port(	d : in STD_LOGIC;
			s000 : in STD_LOGIC_VECTOR (0 downto 1);
			y000 : out STD_LOGIC_VECTOR (0 to 3)
		);		
end demux_1_4;

architecture demux_OOO of demux_1_4 is
	
	begin
		y000(0)   <= 
                    d when s000 = "00" else	'-';
        y000(1)   <= 
                    d when s000 = "01" else	'-';
        y000(2)   <= 
                    d when s000 = "10" else	'-';
        y000(3)   <= 
                    d when s000 = "11" else	'-';

end demux_OOO;