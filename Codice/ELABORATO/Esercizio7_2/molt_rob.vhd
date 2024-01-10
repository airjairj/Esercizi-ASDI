library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity molt_rob is
	 port( clock: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   output_prodotto: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic;
		   start_bottone: in std_logic;
		   reset_bottone: in std_logic);
end molt_rob;

architecture structural of molt_rob is
	component unita_controllo is 
		port( qLSB : std_logic_vector(1 downto 0);
		  clock, reset, start: in std_logic;
		  count: in std_logic_vector(2 downto 0);
		  loadM, count_in, loadAQ, en_shift: out std_logic;
		  selAQ, subtract, stop_cu: out std_logic); 
	end component;
	
	component unita_operativa is
	port( X, Y: in std_logic_vector(7 downto 0);--moltiplicatore e moltiplicando
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
		  count: out std_logic_vector(2 downto 0);
		  P: out std_logic_vector(16 downto 0));
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
	
	signal tempqLSB : std_logic_vector(1 downto 0);
	signal temp_selAQ, temp_clock, temp_sub,temp_loadAQ: std_logic;
	signal temp_count: std_logic_vector(2 downto 0);
	signal temp_p: std_logic_vector(16 downto 0);
	signal temp_count_in, t_load_add: std_logic;
	signal fine_conteggio: std_logic;
	signal temp_shift, temp_fshift: std_logic;
	signal temp_loadM: std_logic;
	signal temp_stop_cu: std_logic; -- segnale di reset generato dalla UC
	signal temp_reset_in: std_logic; -- segnale di reset in ingresso alla UO
	signal start_bottone_pulito: std_logic;
	signal reset_bottone_pulito: std_logic;
	
	begin
	
	UC: unita_controllo port map(
        qLSB => tempqLSB, 
        clock => clock, 
        reset => reset_bottone_pulito, 
        start => start_bottone_pulito, 
        count => temp_count, 
        loadM => temp_loadM, 
        count_in => temp_count_in, 
        loadAQ => temp_loadAQ, 
        en_shift => temp_shift, 
        selAQ => temp_selAQ, 
        subtract => temp_sub, 
        stop_cu => temp_stop_cu
	);
	
		  
	
	UO: unita_operativa port map(
        X => X, 
        Y => Y, 
        clock => clock, 
        reset => reset_bottone_pulito, 
        loadAQ => temp_loadAQ, 
        shift => temp_shift, 
        loadM => temp_loadM, 
        sub => temp_sub, 
        selAQ => temp_selAQ, 
        count_in => temp_count_in, 
        count => temp_count, 
        P => temp_p
	); 
	
	de_B_start: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => reset_bottone_pulito,
            CLK => clock,
            BTN => start_bottone,
            CLEARED_BTN => start_bottone_pulito
        );
        
    de_B_reset: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => clock,
            BTN => reset_bottone,
            CLEARED_BTN => reset_bottone_pulito
        );
	
		  
		  
	tempqLSB<=temp_p(1 downto 0); --invio all'unità di controllo il bit meno significativo del registro A.Q
	output_prodotto<=temp_p(16 downto 1);
	
	-- la UO viene resettata sia se arriva un reset dall'esterno sia se l'operazione di moltiplicazione termina
	--temp_reset_in <= reset or temp_stop_cu;
	
	stop_cu <= temp_stop_cu;
	end structural;