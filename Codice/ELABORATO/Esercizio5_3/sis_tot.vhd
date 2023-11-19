library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot is
    Port (
        RST_tot : in STD_LOGIC;
        CLK_tot : in STD_LOGIC;
        anodes_out : out  STD_LOGIC_VECTOR (7 downto 0); --anodi e catodi delle cifre, sono un output del topmodule
		cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0);
		b_secondi : in STD_LOGIC;
		b_minuti : in STD_LOGIC;
		b_ore : in STD_LOGIC;
		b_salvataggio : in STD_LOGIC;
        lucine_out : out std_logic_vector(7 downto 0);
        switch_in  : in std_logic_vector(7 downto 0);
        val_inizio : in STD_LOGIC_VECTOR(5 downto 0);
        mostra_salvati : in std_logic
    );
end sis_tot;

architecture sis_totArch of sis_tot is

    component MOD_N_COUNTER
    Generic (N : integer := 60); -- Imposta il valore di N come desideri
    Port (
        clk : in std_logic;         -- clock input
        reset : in std_logic;       -- reset input
        enable : in std_logic;
        counter : out integer;
        outp : out std_logic;
        val_iniziale : in std_logic_vector(5 downto 0) := (others => '0');
        btn_iniziale : in std_logic
    );
  end component;
  
    component ButtonDebouncer
        Generic (                       
            CLK_period: integer := 10; -- Period of the board's clock in nanoseconds
            btn_noise_time: integer := 10000000 -- Estimated button bounce duration in nanoseconds
        );
        Port (
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
  end component;
  
    COMPONENT display_seven_segments
	Generic( 
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 500
				);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0)
		);
END COMPONENT;

    COMPONENT clock_filter
	GENERIC(
				CLKIN_freq : integer := 100000000;
				CLKOUT_freq : integer := 1
				);
	PORT(
		clock_in : IN std_logic; 
        reset : in  STD_LOGIC;		
		clock_out : OUT std_logic
		);
END COMPONENT;
    
    COMPONENT  BOH is
    Port (
        secondi : in integer;
        minuti : in integer;
        ore : in integer;
        outp : out std_logic_vector(31 downto 0);
        modalita_normale : in std_logic;
        valore_salvato : in std_logic_vector(31 downto 0)
    );
end COMPONENT;

    component Salvatore is
    Port (
        clk : in std_logic;
        segnale_salva : in std_logic;
        valore : in std_logic_vector(31 downto 0);
        lucine : out std_logic_vector(7 downto 0);
        output_memoria : out std_logic_vector(31 downto 0);
        input_switch : in std_logic_vector(7 downto 0)
    );
end component;

    signal h_intermedio : std_logic;
    signal m_intermedio : std_logic;
    signal s_intermedio : std_logic;
    
    signal b_s_pulito   : std_logic;
    signal b_m_pulito   : std_logic;
    signal b_o_pulito   : std_logic;
    signal b_salvataggio_pulito   : std_logic;
    
    signal val_temp     : std_logic_vector(31 downto 0);
    signal val_salvato  : std_logic_vector(31 downto 0);
    
    signal secondi2     : integer := 0;
    signal minuti2      : integer := 0;
    signal ore2         : integer := 0;
    
    signal clock_BUONO  : std_logic;

begin

    clk_filter: clock_filter GENERIC MAP(
	CLKIN_freq => 100000000,
	CLKOUT_freq => 1
	)
	PORT MAP(
		clock_in => CLK_tot,
		reset => RST_tot,
		clock_out => clock_BUONO
	);
    
    cont_secondi: MOD_N_COUNTER
    generic map (N => 60)
    port map (
        clk => CLK_tot,
        reset => RST_tot,
        enable => clock_BUONO,
        counter => secondi2,
        outp => s_intermedio,
        val_iniziale => val_inizio,
        btn_iniziale => b_s_pulito
    );

    cont_minuti: MOD_N_COUNTER
    generic map (N => 60)
    port map (
        clk => s_intermedio,
        reset => RST_tot,
        enable => CLK_tot,
        counter => minuti2,
        outp => m_intermedio,
        val_iniziale => val_inizio,
        btn_iniziale => b_m_pulito
    );

    cont_ore: MOD_N_COUNTER
    generic map (N => 24)
    port map (
        clk => m_intermedio,
        reset => RST_tot,
        enable => CLK_tot,
        counter => ore2,
        outp => h_intermedio,
        val_iniziale => val_inizio,
        btn_iniziale => b_o_pulito
    );

    de_B_sec: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => CLK_tot,
            BTN => b_secondi,
            CLEARED_BTN => b_s_pulito
        );
        
    de_B_min: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => CLK_tot,
            BTN => b_minuti,
            CLEARED_BTN => b_m_pulito
        );
            
    de_B_ore: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => CLK_tot,
            BTN => b_ore,
            CLEARED_BTN => b_o_pulito
        ); 
        
    de_B_salvataggio: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => CLK_tot,
            BTN => b_salvataggio,
            CLEARED_BTN => b_salvataggio_pulito
        ); 
    
    Macchina_BOH : BOH
    Port map(
        secondi => secondi2,
        minuti => minuti2,
        ore => ore2,
        outp => val_temp,
        modalita_normale => mostra_salvati,
        valore_salvato => val_salvato
    );

    Macchina_Salvatore : Salvatore
    Port map(
        clk => CLK_tot,
        segnale_salva => b_salvataggio_pulito,
        valore => val_temp,
        lucine => lucine_out,
        output_memoria => val_salvato,
        input_switch => switch_in
    );
    
    seven_segment_array: display_seven_segments 
    GENERIC MAP(
	    CLKIN_freq => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
    	CLKOUT_freq => 500 --inserendo un valore inferiore si vedranno le cifre illuminarsi in sequenza
	)
	PORT MAP(
		CLK => CLK_tot,
		RST => '0',
		value => val_temp,
		enable => "11111111", --stabilisco che tutti i display siano accesi 
		dots => "00000000",  --stabilisco che tutti i punti siano spenti
		anodes => anodes_out,
		cathodes => cathodes_out
    );

end sis_totArch;
