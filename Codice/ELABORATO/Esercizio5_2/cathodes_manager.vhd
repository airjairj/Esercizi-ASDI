library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Std_Logic_Arith.all;
use IEEE.NUMERIC_STD.ALL;


entity cathodes_manager is
    Port ( counter : in  STD_LOGIC_VECTOR (2 downto 0);
           value : in  integer;--STD_LOGIC_VECTOR (31 downto 0); --dato di mostrare sugli 8 display
           dots : in  STD_LOGIC_VECTOR (7 downto 0); --configurazione punti da accendere
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0)); --sono i 7 catodi più il punto
end cathodes_manager;

architecture Behavioral of cathodes_manager is
--signal value2 : std_logic_vector(31 downto 0);

constant zero   : std_logic_vector(6 downto 0) := "1000000"; 
constant one    : std_logic_vector(6 downto 0) := "1111001"; 
constant two    : std_logic_vector(6 downto 0) := "0100100"; 
constant three  : std_logic_vector(6 downto 0) := "0110000"; 
constant four   : std_logic_vector(6 downto 0) := "0011001"; 
constant five   : std_logic_vector(6 downto 0) := "0010010"; 
constant six    : std_logic_vector(6 downto 0) := "0000010"; 
constant seven  : std_logic_vector(6 downto 0) := "1111000"; 
constant eight  : std_logic_vector(6 downto 0) := "0000000"; 
constant nine   : std_logic_vector(6 downto 0) := "0010000"; 

signal cathodes_for_digit : std_logic_vector(6 downto 0) := (others => '0');
signal dot :std_logic := '0'; --stabilisce se il punto relativo alla cifra visualizzata deve essere acceso o spento
                              --nota: dot=1 significa che deve essere acceso, ma il segnale deve essere negato per andare sui catodi 

begin 
--value2 <= conv_std_logic_vector(value, value2'length);
seven_segment_decoder_process: process(value) 
  begin
    case value is
    
    when 0 => cathodes_for_digit <= zero; -- "0"  
    when 1 => cathodes_for_digit <= one; -- "1" 
    when 2 => cathodes_for_digit <= two; -- "2" 
    when 3 => cathodes_for_digit <= three; -- "3" 
    when 4 => cathodes_for_digit <= four; -- "4" 
    when 5 => cathodes_for_digit <= five; -- "5" 
    when 6 => cathodes_for_digit <= six; -- "6" 
    when 7 => cathodes_for_digit <= seven; -- "7" 
    when 8 => cathodes_for_digit <= eight; -- "8"     
    when 9 => cathodes_for_digit <= nine; -- "9" 
    when others => cathodes_for_digit <= "0111111"; -- Default case
    
    end case;
  end process seven_segment_decoder_process;
  
cathodes <= (not dot)&cathodes_for_digit; 



end Behavioral;