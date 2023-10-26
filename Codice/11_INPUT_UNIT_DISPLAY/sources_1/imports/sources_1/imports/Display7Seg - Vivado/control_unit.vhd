----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:59:27 10/23/2012 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- la CU ha il compito di caricare la stringa da 32 bit da mostrare sugli 8 display
-- in due passi e di settare hìgli enable per i punti e le cifre

entity control_unit is
    Port ( 
		  clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
           load_dots_enable : in  STD_LOGIC;
		   value16_in : in STD_LOGIC_VECTOR(15 downto 0); --valore acquisito dai 16 switch 
           value32_out : out STD_LOGIC_VECTOR(31 downto 0); --valore su 32 bit da mostrare sui display
           dots : out  STD_LOGIC_VECTOR(7 downto 0); --configurazione dei punti da illuminare
           enable : out  STD_LOGIC_VECTOR(7 downto 0) --configurazione dei display da accendere
			  );
end control_unit;

architecture Behavioral of control_unit is

signal reg_value : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal reg_dots, reg_enable : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin


value32_out <= reg_value; 
dots <= reg_dots;
enable <= reg_enable;

main: process(clock)
begin

	if clock'event and clock = '1' then
	   if reset = '1' then
		  reg_value <= (others => '0');
		  reg_dots <= (others => '0');
		  reg_enable <= (others => '0');
	   else
		  if load_first_part = '1' then
			reg_value(15 downto 0) <= value16_in;
		  elsif load_second_part = '1' then
			reg_value(31 downto 16) <= value16_in;
		  elsif load_dots_enable = '1' then
			reg_enable <= value16_in(15 downto 8);
			reg_dots <= value16_in(7 downto 0);
		  end if;
	 end if;
	end if;

end process;


end Behavioral;

