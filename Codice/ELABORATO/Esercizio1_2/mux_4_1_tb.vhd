library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux_4_1_tb is

end mux_4_1_tb;

architecture structural of mux_4_1_tb is

	component mux_4_1
		port (	
				b0 : in STD_LOGIC;
				b1 : in STD_LOGIC;
				b2 : in STD_LOGIC;
				b3 : in STD_LOGIC;
				s0 : in STD_LOGIC;
				s1 : in STD_LOGIC;
				y0 : out STD_LOGIC
	    	);
		 
	end component; 

	signal input 	: STD_LOGIC_VECTOR (0 to 3) 	:= (others => '0');
	signal control 	: STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal output 	: STD_LOGIC 					:= '0';

	begin

		uut: mux_4_1
				Port map(	
					b0 => input(0),
					b1 => input(1),
					b2 => input(2),
					b3 => input(3),
					s0 => control(0),
					s1 => control(1),
					y0 => output
				);

		stim_proc: process
		begin
		
		wait for 100 ns;
		
		--input = b0 b1 b2 b3
		--control = s1 s0
		
		input 	<= "1010";
		
		control <= "00"; 
		wait for 10 ns; -- b0 = 1  in uscita
		
			
		control <= "01";
		wait for 10 ns; -- b1 = 0 in uscita
		
			
		control <= "10";
		wait for 10 ns; -- b2 = 1 in uscita
		
		control <= "11";
		wait for 10 ns; -- b3 = 0 in uscita
		
		assert output = '0'
		report "errore"
		severity failure;
		
		
		
		
		wait;
		end process;
end; 