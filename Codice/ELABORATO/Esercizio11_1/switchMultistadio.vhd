library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity switchMultistadio is port(  
    a1 : in std_logic_vector(1 downto 0);
    a2 : in std_logic_vector(1 downto 0);
    a3 : in std_logic_vector(1 downto 0);
    a4 : in std_logic_vector(1 downto 0);
    y1 : out std_logic_vector(1 downto 0);
    y2 : out std_logic_vector(1 downto 0);
    y3 : out std_logic_vector(1 downto 0);
    y4 : out std_logic_vector(1 downto 0);
    selezione1 : in std_logic;
    selezione2 : in std_logic;
    selezione3 : in std_logic;
    selezione4 : in std_logic;
    uscitas : in std_logic_vector(1 downto 0)
);
end switchMultistadio;

architecture strutturale of switchMultistadio is

    component UC_switch is port(
        a1 : in std_logic_vector(1 downto 0);
        a2 : in std_logic_vector(1 downto 0);
        a3 : in std_logic_vector(1 downto 0);
        a4 : in std_logic_vector(1 downto 0);
        y1 : out std_logic_vector(1 downto 0);
        y2 : out std_logic_vector(1 downto 0);
        y3 : out std_logic_vector(1 downto 0);
        y4 : out std_logic_vector(1 downto 0);
        selezione1 : in std_logic;
        selezione2 : in std_logic;
        selezione3 : in std_logic;
        selezione4 : in std_logic;
        uscita_selezione : in std_logic_vector(1 downto 0);
        selezione_input : out std_logic_vector(1 downto 0);
        selezione_output : out std_logic_vector(1 downto 0)
    );
    end component;
    
    component UO_switch is port(
        messaggio1 : in std_logic_vector(1 downto 0);
        messaggio2 : in std_logic_vector(1 downto 0);
        messaggio3 : in std_logic_vector(1 downto 0);
        messaggio4 : in std_logic_vector(1 downto 0);
        selezione_input : in std_logic_vector(1 downto 0);
        selezione_output : in std_logic_vector(1 downto 0);
        uscita1 : out std_logic_vector(1 downto 0);
        uscita2 : out std_logic_vector(1 downto 0);
        uscita3 : out std_logic_vector(1 downto 0);
        uscita4 : out std_logic_vector(1 downto 0)
    );
    end component;

    signal selezione_input : std_logic_vector(1 downto 0);
    signal selezione_output : std_logic_vector(1 downto 0);
    signal messaggio1 : std_logic_vector(1 downto 0);
    signal messaggio2 : std_logic_vector(1 downto 0);
    signal messaggio3 : std_logic_vector(1 downto 0);
    signal messaggio4 : std_logic_vector(1 downto 0);

begin

    uc : UC_Switch port map(
        a1 => a1,
        a2 => a2,
        a3 => a3,
        a4 => a4,
        selezione1 => selezione1,
        selezione2 => selezione2,
        selezione3 => selezione3,
        selezione4 => selezione4,
        uscita_selezione => uscitas,
        selezione_input => selezione_input,
        selezione_output => selezione_output,
        y1 => messaggio1,
        y2 => messaggio2,
        y3 => messaggio3,
        y4 => messaggio4
    );
    
    
    uo: UO_Switch port map(
        selezione_input => selezione_input,
        selezione_output => selezione_output,
        messaggio1 => a1,
        messaggio2 => a2,
        messaggio3 => a3,
        messaggio4 => a4,
        uscita1 => y1,
        uscita2 => y2,
        uscita3 => y3,
        uscita4 => y4
    );


end strutturale;
