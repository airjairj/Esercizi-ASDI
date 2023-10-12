library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DELTAexample_tb is
end DELTAexample_tb;

architecture beh of DELTAexample_tb is

	component DELTAexample is

	port( 	x 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
	end component;
	
	signal input 	: STD_LOGIC :='0'; 
	signal output 	: STD_LOGIC :='U';

	begin
	
		utt : DELTAexample port map(
			x=> input,
			y => output
		);
		
		stim_proc : process
		begin
		
		wait for 100 ns;
		
		input 	<= '1';
		wait for 20 ns; 

		input <= '0';  
		wait for 20 ns;
		
		input <= '1';
		
				
		
		
		
		
		wait;
		end process;

end;
