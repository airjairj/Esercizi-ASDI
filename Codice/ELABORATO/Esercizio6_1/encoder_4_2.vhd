library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity encoder_4_2 is

	port( 	a_enc : in STD_LOGIC_VECTOR (0 to 3);
			y_enc : out STD_LOGIC_VECTOR (0 to 1)
	);
		
end encoder_4_2;



architecture EncArch of encoder_4_2 is
	
	begin
		y_enc 	<= 	"00" when a_enc="0001" else
		        	"01" when a_enc="0010" else
					"10" when a_enc="0100" else
					"11" when a_enc="1000" else
					"--";
		        	
end EncArch;
