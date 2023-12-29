library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFD is
	port( clock, reset, d: in std_logic;
          y: out std_logic :='0');
end FFD;

architecture behavioural of FFD is

	begin
	
	FF_D: process(clock)
		  begin
			if(clock'event and clock='1') then 
		       if(reset='1') then	
				  y<='0';
			   else			
			      y<=d;
			   end if;
			end if;
		  end process;
		  
	
	end behavioural;