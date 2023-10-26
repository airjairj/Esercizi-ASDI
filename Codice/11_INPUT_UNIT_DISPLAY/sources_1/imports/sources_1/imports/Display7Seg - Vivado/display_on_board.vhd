----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- Il seguente modulo consente la visualizzazione su una board di sviluppo
-- dotata di 8 display a 7 segmenti, 16 switch, 5 bottoni, 
-- di un valore di 32 bit codificato in esadecimale sulle 8 cifre del display.
-- Il valore di 32 bit da mostrare sul display viene inserito in due step successivi (16 bit alla volta)
-- mediante la pressione di appositi bottoni. E' inoltre possibile scegliere, mediante una
-- apposita configurazione degli switch e la pressione di un bottone, quali display "accendere"
-- e quali punti illuminare.
-- Lo scenario di funzionamento atteso del componente  il seguente:
-- 1) vengono inseriti i 16 bit meno significativi tramite gli switch e, alla pressione
-- di un bottone (BTNL), il valore viene caricato nella prima meta' di un registro interno
-- 2) vengono inseriti i 16 bit piu' significativi tramite gli switch e, alla pressione
-- di un altro bottone (BTNR), il valore viene caricato nella seconda meta' di un registro interno
-- 3) vengono inseriti altri 16 bit tramite gli switch: gli 8 bit meno significativi rappresentano
-- un comando di "accensione" del puntino in ciascuna delle 8 cifre del display, mentre
-- gli 8 bit piu' significativi rappresentano un comando di accensione di ogni singola cifra.
-- l'abilitazione di punti e digit avviene tramite pressione del bottone BTNU


entity display_on_board is
	Port(
		  clock : in  STD_LOGIC; --clock board
		  reset : in  STD_LOGIC; --reset, associato a un bottone
		  load_first_part : in  STD_LOGIC; --comando di caricamento 16bit meno significativi, associato a un bottone
		  load_second_part : in  STD_LOGIC; --comando di caricaernto 16bit più significativi, associato a un bottone
		  load_dots_enable : in  STD_LOGIC; --comando di caricamento punti e cifre da accendere, associato a un bottone
		  value16_in : in STD_LOGIC_VECTOR(15 downto 0);  --input di 16 bit inserito tramite switch (di volta in volta
		     --in base al segnale di controllo corrisponderà alle due metà del valore da visualizzare o alla configurazione
		     --di accensione dei display e dei punti
		  anodes : out  STD_LOGIC_VECTOR (7 downto 0); --segnali associati agli anodi delle 8 cifre
		  cathodes : out  STD_LOGIC_VECTOR (7 downto 0) --segnali associati ai catodi comuni delle 8 cifre (comprendono il
		                                                --catodo del punto)
			  );
end display_on_board;

architecture Structural of display_on_board is

COMPONENT display_seven_segments
	GENERIC(
				clock_frequency_in : integer := 100000000; --questi parametri servono a configurare
				clock_frequency_out : integer := 500       --il clock filter
				);
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		value32_in : IN std_logic_vector(31 downto 0); -- valore su 32 bit da mostrare complessivamente sugli 8 display
		enable : IN std_logic_vector(7 downto 0);--abilitazione delle 8 cifre
		dots : IN std_logic_vector(7 downto 0); --punti        
		anodes : OUT std_logic_vector(7 downto 0);
		cathodes : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT control_unit
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		load_first_part : IN std_logic;
		load_second_part : IN std_logic;
		load_dots_enable : IN std_logic;
		value16_in : IN std_logic_vector(15 downto 0);
		value32_out : OUT std_logic_vector(31 downto 0); 
		dots : OUT std_logic_vector(7 downto 0);
		enable : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;


signal cu_value : std_logic_vector(31 downto 0);
signal cu_enable : std_logic_vector(7 downto 0);
signal cu_dots : std_logic_vector(7 downto 0);

begin



cu: control_unit PORT MAP(
		clock => clock,
		reset => reset,
		load_first_part => load_first_part,
		load_second_part => load_second_part,
		load_dots_enable => load_dots_enable,
		value16_in => value16_in,
		value32_out => cu_value,
		dots => cu_dots,
		enable => cu_enable
	);

seven_segment_array: display_seven_segments GENERIC MAP(
	clock_frequency_in => 100000000, --qui inserisco i parametri effettivi (clock della board e impulso in uscita desiderato)
	clock_frequency_out => 500
		)
	PORT MAP(
		clock => clock,
		reset => reset,
		value32_in => cu_value,
		enable => cu_enable,
		dots => cu_dots,
		anodes => anodes,
		cathodes => cathodes
);



end Structural;

