library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--registro parallelo-parallelo che mantiene il valore del moltiplicando Y
entity registro8 is 
	port( A: in std_logic_vector(7 downto 0);
		  clk, res, load: in std_logic;
		  B: out std_logic_vector(7 downto 0));
end registro8;

architecture behavioural of registro8 is
	signal temp_b: std_logic_vector(7 downto 0);
	begin
	
	R_PP: process(clk)
		begin
		if(clk'event and clk='1') then
		  if(res='1') then
			 temp_b<= (others=>'0');		   
		  else
		    if(load='1') then
			   temp_b<=A;
	        end if;
	      end if;
	    end if;
	end process;
	B<=temp_b;
end behavioural;
		  