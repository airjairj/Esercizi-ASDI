library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.std_logic_unsigned.ALL;

entity cont_mod8 is
	port( clock, reset: in std_logic;
	      count_in: in std_logic;
		  count: out std_logic_vector(2 downto 0));
end cont_mod8;

architecture behavioural of cont_mod8 is
	signal c: std_logic_vector(2 downto 0) := (others=>'0');
	
	begin	
	CM8: process(clock)
	begin
		if(clock'event and clock='1') then 
		
		   if(reset='1') then 
			   c <= (others=>'0');
		   else 
		       if(count_in = '1') then
			      c <= std_logic_vector(unsigned(c) + 1);
			      -- c <= c + "111"; posso fare direttamente questa somma se importo IEEE.std_logic_unisigned.ALL
			      -- è preferibile non farlo perchè sono package non standard
		       end if;
		   end if;
		 end if;
	end process;
	
	count <= c;
	
	end behavioural;