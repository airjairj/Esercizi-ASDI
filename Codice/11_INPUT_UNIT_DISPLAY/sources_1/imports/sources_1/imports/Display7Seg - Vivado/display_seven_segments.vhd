----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:25 09/16/2012 
-- Design Name: 
-- Module Name:    display_seven_segments - Behavioral 
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

entity display_seven_segments is
	Generic( 
				clock_frequency_in : integer := 50000000; 
				clock_frequency_out : integer := 5000000
				);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end display_seven_segments;

architecture Structural of display_seven_segments is

signal counter : std_logic_vector(2 downto 0);
signal value_digit : std_logic_vector(3 downto 0);
signal clock_fx,dot_digit : std_logic := '0';

COMPONENT counter_mod8
	PORT(
		clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		enable : in STD_LOGIC;
        counter : out  STD_LOGIC_VECTOR (2 downto 0)
		);
END COMPONENT;


COMPONENT cathodes_input_manager
  PORT (
       counter : in std_logic_vector(2 downto 0);
       value_in: in std_logic_vector(31 downto 0);
       dots_in : in std_logic_vector(7 downto 0);
       nibble_out : out std_logic_vector(3 downto 0);
       dot_out : out std_logic
       );
END COMPONENT;  

          
       
COMPONENT cathodes_manager
	PORT(
		value : in  STD_LOGIC_VECTOR (3 downto 0); --dato da mostrare sulla cifra del display
        dot : in  STD_LOGIC; --punto
        cathodes_dot : out  STD_LOGIC_VECTOR (7 downto 0)
		);
END COMPONENT;

COMPONENT anodes_manager
	PORT(

		counter : IN std_logic_vector(2 downto 0);
		enable_digit : IN std_logic_vector(7 downto 0);          
		anodes : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT clock_divider
	GENERIC(
				clock_frequency_in : integer := 100000000;--100MHz
				clock_frequency_out : integer := 500 --500 Hz
				);
	PORT(
		clock_in : IN std_logic; 
        reset : in  STD_LOGIC;		
		clock_out : OUT std_logic
		);
END COMPONENT;
begin
--il clock divider genera un segnale di abilitazione per il contatore mod8 che viene usato
--come segnale di conteggio e quindi di fatto fornisce la frequenza con cui viene modificata
--la cifra da mostrare

clk_divider_instance: clock_divider generic map(
	clock_frequency_in => clock_frequency_in,
	clock_frequency_out => clock_frequency_out
	)
	port map(
		clock_in => clock,
		reset => reset,
		clock_out => clock_fx
	);

counter_instance: counter_mod8 port map(
	clock => clock,
	enable => clock_fx,
	reset => reset,
	counter => counter
);

cathodes_input_man_instance : cathodes_input_manager port map(
       counter => counter, 
       value_in => value32_in,
       dots_in => dots,
       nibble_out => value_digit,
       dot_out => dot_digit
);
--il valore di conteggio viene usato dal gestore dei catodi e degli anodi per
--selezionare l'anodo da accendere e il suo rispettivo valore
cathodes_instance: cathodes_manager port map(
	value => value_digit,
	dot => dot_digit,
	cathodes_dot => cathodes
);

anodes_instance: anodes_manager port map(
	counter => counter,
	enable_digit => enable,
	anodes => anodes
);


end Structural;

