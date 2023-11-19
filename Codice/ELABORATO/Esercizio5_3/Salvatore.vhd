library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.Std_Logic_Arith.ALL;

-- Questa macchina si chiama Salvatore perchè coordina il salvataggio

entity Salvatore is
    Port (
        clk : in std_logic;
        segnale_salva : in std_logic;
        valore : in std_logic_vector(31 downto 0);
        lucine : out std_logic_vector(7 downto 0);
        output_memoria : out std_logic_vector(31 downto 0);
        input_switch : in std_logic_vector(7 downto 0)
        
    );
end Salvatore;

architecture SalvatoreArch of Salvatore is

    component MEM is
        port(
            CLK : in std_logic;
            s_write : in std_logic;
            indirizzo : in std_logic_vector(3 downto 0);
            out_val : out std_logic_vector(31 downto 0);
            out_lucine : out std_logic_vector(7 downto 0);
            intertempi : in std_logic_vector(31 downto 0)
        );
    end component;

    component Encoder is
        Port(
            X : in STD_LOGIC_VECTOR(7 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
           );
    end component;

    signal indirizzo_intermedio : std_logic_vector(3 downto 0);

begin
    
    encoder_memoria: Encoder
    port map (
        X => input_switch,
        Y => indirizzo_intermedio
    );

    memoria_intertempi: MEM
    port map(
        CLK => clk,
        s_write => segnale_salva,
        indirizzo => indirizzo_intermedio,
        out_val => output_memoria,
        out_lucine => lucine,
        intertempi => valore
    );

end SalvatoreArch;
