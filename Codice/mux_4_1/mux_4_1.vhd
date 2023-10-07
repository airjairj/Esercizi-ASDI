library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_4_1.
entity mux_4_1 is 
	port(	a_mux : in STD_LOGIC_VECTOR (0 to 3);
			s_mux : in STD_LOGIC_VECTOR (1 downto 0);
			y_mux : out STD_LOGIC
		);		
end mux_4_1;

architecture MuxArch of mux_4_1 is

	begin
		y_mux 	<=
		       	a_mux(0) when s_mux = "00" else	
				a_mux(1) when s_mux = "01" else
				a_mux(2) when s_mux = "10" else
				a_mux(3) when s_mux = "11" else
				'-';

end MuxArch;
