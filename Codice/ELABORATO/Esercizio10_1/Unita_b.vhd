library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Unita_b is
    Port (        
        rst_nodo : in STD_LOGIC;
        clk_nodo : in STD_LOGIC;
		rxd_nodo : in STD_LOGIC;
		stop_read : in std_logic := '0';
		canale_invio_richieste : in STD_LOGIC  := '0';
		canale_lettura_risposte : out STD_LOGIC := '0'
    );
end Unita_b;

architecture Unita_bArch of Unita_b is
	signal rda_temp : std_logic := '0';
	signal rd_temp  : std_logic := '0';
	signal bus_input  : std_logic_vector(7 downto 0);
	signal bus_output  : std_logic_vector(7 downto 0);
	signal bus_temp  : std_logic_vector(7 downto 0);

    signal temp0 : std_logic := '0';
	signal temp1 : std_logic := '0';
	signal parity : std_logic := '0';
	signal frame : std_logic := '0';
	signal overwrite : std_logic := '0';
	signal temp5 : std_logic_vector(7 downto 0);
	

	signal o_contatore  : std_logic_vector(2 downto 0);
	signal e_contatore  : std_logic := '0';
	signal e_write_mem  : std_logic := '0';
	signal mem_data_out : std_logic_vector(7 downto 0);

	type stato is (IDLE, RICEZIONE, SCRITTURA); 
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

  component MEM
  	port(
		CLK     : in std_logic;
		s_write : in std_logic;
		address : in std_logic_vector (2 downto 0);
		out_val : out std_logic_vector(7 downto 0);
		inp_val : in std_logic_vector(7 downto 0)
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
    UART_B: Rs232RefComp
    port map
    (
        TXD   => temp0,
    	RXD   => rxd_nodo,	
    	CLK   => clk_nodo,--Master Clock
		DBIN  => bus_input,--Data Bus in
		DBOUT => bus_output,--Data Bus out
		RDA	  => rda_temp,--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		TBE	  => temp1,--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
		RD    => rd_temp,--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		WR    => '0',--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
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

	MEM0: MEM
	Port map(	
		CLK     => clk_nodo,
		address => o_contatore,
		s_write => e_write_mem,
		out_val => mem_data_out,
		inp_val => bus_temp
		);

	
	f_stato_uscita: process(clk_nodo)
		begin
			if (rst_nodo = '1') then
				stato_prossimo <= IDLE;
			else
								
				case stato_attuale is 

					when IDLE =>
                        e_contatore <= '0';
						e_write_mem <= '0';
						if (canale_invio_richieste = '1') then
							canale_lettura_risposte <= '1'; --CTS
							stato_prossimo <= RICEZIONE;
							rd_temp <= '1';
						else 
						    rd_temp <= '0';
							stato_prossimo <= IDLE;
						end if;

					when RICEZIONE =>
						canale_lettura_risposte <= '0'; -- OK CTS
						if (stop_read = '1') then
							stato_prossimo <= SCRITTURA;
						else 
							stato_prossimo <= RICEZIONE;
						end if;

					when SCRITTURA =>
                        rd_temp <= '0';
						bus_temp <= bus_output;
                        if (rda_temp = '1') then
                            e_write_mem <= '1';
                            e_contatore <= '1';
                            stato_prossimo <= IDLE;
                        else
                            stato_prossimo <= SCRITTURA;
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

end Unita_bArch;