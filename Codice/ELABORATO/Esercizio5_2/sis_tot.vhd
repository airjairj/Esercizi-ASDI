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
        val_inizio : in STD_LOGIC_VECTOR(5 downto 0)
    );
end sis_tot;

architecture sis_totArch of sis_tot is

    component MOD_N_COUNTER
    Generic (N : integer := 60); -- Imposta il valore di N come desideri
    Port (
        clk : in std_logic;         -- clock input
        reset : in std_logic;       -- reset input
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
	GENERIC(
		CLKIN_freq : integer := 100000000; --frequenza del clock in input: quello della board NexysA7 ? a 100MHz
		CLKOUT_freq : integer := 500  --frequenza dell'impulso in uscita, in corrispondenza del quale 
		                              --si scandisce ciascuna cifra (deve essere compreso fra 500Hz e 8KHz)
				);
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		VALUE : IN integer;--valori da mostrare sugli 8 display
		ENABLE : IN std_logic_vector(7 downto 0);--abilitazione di ciascuna cifra (accensione)
		DOTS : IN std_logic_vector(7 downto 0); --abilitazione punti (accensione)      
		ANODES : OUT std_logic_vector(7 downto 0);
		CATHODES : OUT std_logic_vector(7 downto 0)
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

    signal h_intermedio : std_logic;
    signal m_intermedio : std_logic;
    signal s_intermedio : std_logic;
    signal b_s_pulito   : std_logic;
    signal b_m_pulito   : std_logic;
    signal b_o_pulito   : std_logic;
    signal val_temp     : std_logic_vector(31 downto 0);
    signal secondi2     : integer;
    signal minuti2      : integer;
    signal ore2         : integer;
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
        clk => clock_BUONO,
        reset => RST_tot,
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
    
    seven_segment_array: display_seven_segments GENERIC MAP(
	CLKIN_freq => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
	CLKOUT_freq => 500 --inserendo un valore inferiore si vedranno le cifre illuminarsi in sequenza
	)
	PORT MAP(
		CLK => CLK_tot,
		RST => RST_tot,
		value => secondi2,
		enable => "11111111", --stabilisco che tutti i display siano accesi 
		dots => "00000000",  --stabilisco che tutti i punti siano spenti
		anodes => anodes_out,
		cathodes => cathodes_out
    );

end sis_totArch;
