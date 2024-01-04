library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Unita_a is
    Port (     
		start : in STD_LOGIC;   
        rst_nodo : in STD_LOGIC;
        clk_nodo : in STD_LOGIC;
		txd_nodo : out STD_LOGIC;
		stop_read : out std_logic := '0';
		canale_invio_richieste : out STD_LOGIC  := '0';
		canale_lettura_risposte : in STD_LOGIC := '0'
    );
end Unita_a;

architecture Unita_aArch of Unita_a is
    signal tbe_temp : std_logic := '1';
	signal wr_temp  : std_logic := '0';
	signal bus_input : std_logic_vector(7 downto 0);
	signal bus_output : std_logic_vector(7 downto 0);
	
	signal rda_temp : std_logic := '0';
	signal parity : std_logic := '0';
	signal frame : std_logic := '0';
	signal overwrite : std_logic := '0';
	signal temp4 : std_logic_vector(7 downto 0);
	signal temp5 : std_logic := '0';

	signal o_contatore  : std_logic_vector(2 downto 0);
	signal e_contatore  : std_logic := '0';
	signal e_read_rom   : std_logic := '0';
	signal rom_data_out : std_logic_vector(7 downto 0);


	type stato is (IDLE, PREPARAZIONE, TRASMISSIONE); 
    signal stato_attuale : stato := IDLE;
    signal stato_prossimo : stato;

  component Rs232RefComp is
    Port ( 
		TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;					--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
		DBOUT   : out std_logic_vector (7 downto 0);--Data Bus out
		RDA	    : inout std_logic;					--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		TBE	    : inout std_logic 	:= '1';			--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
		RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		PE		: out std_logic;					--Parity Error Flag
		FE		: out std_logic;					--Frame Error Flag
		OE		: out std_logic;					--Overwrite Error Flag
		RST		: in  std_logic	:= '0');			--Master Reset
  end component;

  component ROM is
    port(
        CLK     : in STD_LOGIC;
        s_read  : in std_logic;
        address : in std_logic_vector (2 downto 0);
        out_rom : out std_logic_vector(7 downto 0)
    );
  end component;

  component MOD_N_COUNTER
	Generic (N : integer := 8);  -- Imposta il valore di N come desideri
	Port (
		clk           : in std_logic;      -- clock input
		reset         : in std_logic;      -- reset input
		enable        : in std_logic;      -- start
		counter       : out std_logic_vector (2 downto 0)
	  );
  end component;

begin
    UART_A: Rs232RefComp
    port map
    (
        TXD   => txd_nodo,
    	RXD   => temp5,	
    	CLK   => clk_nodo,--Master Clock
		DBIN  => bus_input,--Data Bus in
		DBOUT => bus_output,--Data Bus out
		RDA	  => rda_temp,--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		TBE	  => tbe_temp,--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
		RD    => '0',--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		WR    => wr_temp,--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		PE    => parity,--Parity Error Flag
		FE    => frame,--Frame Error Flag
		OE    => overwrite,--Overwrite Error Flag
		RST   => rst_nodo		
    );

	Cont_A: MOD_N_COUNTER
	generic map (
		N => 8
	)
	Port map(	
		clk     => clk_nodo,
		reset   => rst_nodo,
		enable  => e_contatore,
		counter => o_contatore
	);

	ROM_A: ROM
	Port map(	
		CLK     => clk_nodo,
		s_read  => '1',
		address => o_contatore,
		out_rom => rom_data_out
		);

	f_stato_uscita: process(clk_nodo)
		begin
			if (rst_nodo = '1') then
				stato_prossimo <= IDLE;
			else
								
				case stato_attuale is 
					
					when IDLE =>
						wr_temp <= '0';
						if (start = '1') then
							stato_prossimo <= PREPARAZIONE;
							e_contatore <= '1';
							e_read_rom <= '1';
						else 
							stato_prossimo <= IDLE;
						end if;
						
					when PREPARAZIONE =>
					    if e_read_rom = '1' then
						  bus_input <= rom_data_out;
						  e_contatore <= '0';
						  e_read_rom <= '0';
						 end if;

						canale_invio_richieste <= '1'; --RTS

						if (canale_lettura_risposte = '1') then --SE ARRIVA CTS
							canale_invio_richieste <= '0';--OK RTS
							stato_prossimo <= TRASMISSIONE;
                            wr_temp <= '1';
						else 
							stato_prossimo <= PREPARAZIONE;
						end if;

					when TRASMISSIONE =>
                        if wr_temp <= '1' then
                              wr_temp <= '0';
                            end if;
						if (rda_temp = '1') then
                            stop_read <= '1';
							stato_prossimo <= IDLE;
						else 
							stato_prossimo <= TRASMISSIONE;
							
						end if;

						when others =>
							stato_prossimo <= IDLE;
				end case;
	
			end if;
	end process;
	
	cambio_stato: process (clk_nodo)
		begin
			if (rising_edge(clk_nodo) and clk_nodo = '1') then
				stato_attuale <= stato_prossimo;
			end if;
	end process;


end Unita_aArch;