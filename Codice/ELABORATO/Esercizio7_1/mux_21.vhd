library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_21 is
    generic (width : integer range 0 to 17 := 8);
	port( x0, x1: in std_logic_vector(width-1 downto 0); 
		  s: in std_logic;
		  y: out std_logic_vector(width-1 downto 0));
end mux_21;

architecture rtl of mux_21 is

	begin
	
	y <= x0 when s='0' else 
	    x1 when s='1' else
		(others => '0');
    end rtl;

		
		