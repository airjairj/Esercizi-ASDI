library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is port (
    ingresso1 : in std_logic_vector(1 downto 0);
    ingresso2 : in std_logic_vector(1 downto 0);
    selezione_input : in std_logic;
    selezione_output : in std_logic;
    uscita1 : out std_logic_vector(1 downto 0);
    uscita2 : out std_logic_vector(1 downto 0)
);
end switch;

architecture strutturale of switch is 

    signal temp : std_logic_vector(1 downto 0);

    component mux_2_1 is 
    port(
        a0 	: in std_logic_vector(1 downto 0);
        a1 	: in std_logic_vector(1 downto 0);
        s 	: in STD_LOGIC;
        y 	: out std_logic_vector(1 downto 0)
    );
    end component;
    
    component demux1_2 is 
    port(
        a	: in STD_LOGIC_VECTOR(1 downto 0);
        sel : in std_logic;
        y1	: out STD_LOGIC_VECTOR(1 downto 0);
        y2	: out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

begin

    m: mux_2_1 
    port map(
        a0 => ingresso1,
        a1 => ingresso2,
        s => selezione_input,
        y => temp
    );

    d : demux1_2 
    port map(
        a => temp,
        sel => selezione_output,
        y1 => uscita1,
        y2 => uscita2
    );

end strutturale;

