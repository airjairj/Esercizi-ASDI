----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- questo componente si occupa di selezionare il nibble da mostrare sulla cifra illuminata
-- in base al valore del counter; il componente si occupa anche di accendere o meno il punto
entity cathodes_input_manager is
  Port (
       counter : in std_logic_vector(2 downto 0);
       value_in: in std_logic_vector(31 downto 0);
       dots_in: in std_logic_vector(7 downto 0); --configurazione dei punti degli 8 display
       nibble_out : out std_logic_vector(3 downto 0); --nibble da mostrare in base alla selezione
       dot_out : out std_logic --punto da mostrare in base alla selezione
       );
end cathodes_input_manager;

architecture Behavioral of cathodes_input_manager is

begin

with counter select
   nibble_out <= value_in(31 downto 28) when "111",
           value_in(27 downto 24) when "110",
           value_in(23 downto 20) when "101",
           value_in(19 downto 16) when "100",
           value_in(15 downto 12) when "011",
           value_in(11 downto 8) when "010",
           value_in(7 downto 4) when "001",
           value_in(3 downto 0) when "000",
           "0000" when others;
    
with counter select
   dot_out <= dots_in(7)when "111",
           dots_in(6) when "110",
           dots_in(5) when "101",
           dots_in(4) when "100",
           dots_in(3) when "011",
           dots_in(2) when "010",
           dots_in(1) when "001",
           dots_in(0) when "000",
           '0' when others;
    
end Behavioral;
