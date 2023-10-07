library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_2_4 is

	port( 	a_dec : in STD_LOGIC_VECTOR (1 downto 0);
			y_dec : out STD_LOGIC_VECTOR (0 to 3)
	);
		
end decoder_2_4;

architecture DecArch of decoder_2_4 is
	
	begin
		y_dec 	<= 	"0001" when a_dec="00" else
		        "0010" when a_dec="01" else
		        "0100" when a_dec="10" else
		        "1000" when a_dec="11" else
		        "----";
		        	
end DecArch;