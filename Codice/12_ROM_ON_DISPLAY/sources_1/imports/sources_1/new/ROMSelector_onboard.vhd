----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    ROM_Selector_onboard - Behavioral 
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


entity ROM_selector_onboard is
	Port(
		  clock_in : in  STD_LOGIC;
		  reset_in : in  STD_LOGIC;
		  addr_strobe_in : in  STD_LOGIC; -- bottone che fa scandire le locazioni della ROM (è l'enable del contatore
		                                  -- che fornisce l'indirizzo alla memoria)
		  anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		  cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end ROM_selector_onboard;

architecture Structural of ROM_selector_onboard is

COMPONENT ButtonDebouncer 
    GENERIC (                       
        CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
        btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi  
                                            -- il valore di default è 10ms                                         -- il valore di default è 10 millisecondi
    );
    PORT ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
END COMPONENT;

COMPONENT counter_mod8
	PORT(
		clock : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		enable : in STD_LOGIC;
        counter : out  STD_LOGIC_VECTOR (2 downto 0)  --fornisce l'indirizzo alla memoria
		);
END COMPONENT;


COMPONENT ROM
PORT (
    RST: in std_logic;
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono forniti dall'uscita del contatore
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
);
END COMPONENT;

    
COMPONENT display_seven_segments
	GENERIC(
		CLKIN_freq : integer := 100000000; --frequenza del clock in input: quello della board NexysA7 è a 100MHz
		CLKOUT_freq : integer := 500  --frequenza dell'impulso in uscita, in corrispondenza del quale 
		                              --si scandisce ciascuna cifra (deve essere compreso fra 500Hz e 8KHz)
				);
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		VALUE : IN std_logic_vector(31 downto 0);--valori da mostrare sugli 8 display
		ENABLE : IN std_logic_vector(7 downto 0);--abilitazione di ciascuna cifra (accensione)
		DOTS : IN std_logic_vector(7 downto 0); --abilitazione punti (accensione)      
		ANODES : OUT std_logic_vector(7 downto 0);
		CATHODES : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;


signal reset_n, read_strobe : std_logic;
signal value_temp : std_logic_vector(31 downto 0);
signal address_in : STD_LOGIC_VECTOR(2 downto 0); 

begin

reset_n <= not reset_in;  --visto che utilizzo il bottone CPU_reset della board, che è attivo-basso,
                          --devo convertire il segnale di reset

debouncer: ButtonDebouncer GENERIC MAP( 
        CLK_period => 10,  -- periodo del clock della board pari a 10ns
        btn_noise_time => 10000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                    --assumo che duri 10ms
)
PORT MAP ( RST => reset_n,
           CLK => clock_in, 
           BTN => addr_strobe_in,
           CLEARED_BTN => read_strobe
);

counter: counter_mod8
	PORT MAP(
		clock=> clock_in,
        reset => reset_n,
		enable => read_strobe,
        counter => address_in
		);


mem: ROM
PORT MAP (
    rst => reset_n,
    addr => address_in,
    data => value_temp
    );
    
 seven_segment_array: display_seven_segments GENERIC MAP(
	CLKIN_freq => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
	CLKOUT_freq => 500 --inserendo un valore inferiore si vedranno le cifre illuminarsi in sequenza
	)
	PORT MAP(
		CLK => clock_in,
		RST => reset_n,
		value => value_temp,
		enable => "11111111", --stabilisco che tutti i display siano accesi 
		dots => "00000000",  --stabilisco che tutti i punti siano spenti
		anodes => anodes_out,
		cathodes => cathodes_out
);


end Structural;

