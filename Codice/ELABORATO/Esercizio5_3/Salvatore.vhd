library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.Std_Logic_Arith.ALL;

-- Questa macchina si chiama Salvatore perchÃ¨ coordina il salvataggio

entity Salvatore is
    Port (
        clk : in std_logic;
        segnale_salva : in std_logic;
        valore : in std_logic_vector(31 downto 0);
        lucine : out std_logic_vector(7 downto 0);
        output_memoria : out std_logic_vector(31 downto 0)
    );
end Salvatore;

architecture SalvatoreArch of Salvatore is

    component MEM is
        port(
            CLK : in std_logic;
            s_write : in std_logic;
            address : in integer;
            out_val : out std_logic_vector(31 downto 0);
            out_lucine : out std_logic_vector(7 downto 0);
            intertempi : in std_logic_vector(31 downto 0)
        );
    end component;

    component MOD_N_COUNTER
    Generic (N : integer := 8); -- Imposta il valore di N come desideri
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

    signal indirizzo_intermedio : integer := 0;
    signal button_fittizzio : std_logic := '0'; --fittizzio
    signal output_contatore : std_logic := '0'; --fittizzio

begin
    
    cont_memoria: MOD_N_COUNTER
    generic map (N => 8)
    port map (
        clk => segnale_salva,
        reset => '0',
        enable => clk,
        counter => indirizzo_intermedio,
        outp => output_contatore,
        val_iniziale => "000000",
        btn_iniziale => button_fittizzio
    );

    memoria_intertempi: MEM
    port map(
        CLK => clk,
        s_write => segnale_salva,
        address => indirizzo_intermedio,
        out_val => output_memoria,
        out_lucine => lucine,
        intertempi => valore
    );

end SalvatoreArch;
