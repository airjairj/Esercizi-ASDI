library IEEE;
use IEEE.std_logic_1164.all;

entity UO_switch is port(
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
end UO_switch;

architecture strutturale of UO_switch is
    
    signal temp1 : std_logic_vector(1 downto 0);
    signal temp2 : std_logic_vector(1 downto 0);
    signal temp3 : std_logic_vector(1 downto 0);
    signal temp4 : std_logic_vector(1 downto 0);
    
    component switch is port(
        ingresso1 : in std_logic_vector(1 downto 0);
        ingresso2 : in std_logic_vector(1 downto 0);
        selezione_input : in std_logic;
        selezione_output : in std_logic;
        uscita1 : out std_logic_vector(1 downto 0);
        uscita2 : out std_logic_vector(1 downto 0)
    );
    end component;
    
    begin 
    
        switch1 : switch port map(
            ingresso1 => messaggio1,
            ingresso2 => messaggio3,
            selezione_input => selezione_input(1),
            selezione_output => selezione_output(1),
            uscita1 => temp1,
            uscita2 => temp2
        );
        
        switch2 : switch port map(
            ingresso1 => messaggio2,
            ingresso2 => messaggio4,
            selezione_input => selezione_input(1),
            selezione_output => selezione_output(1),
            uscita1 => temp3,
            uscita2 => temp4
        );
        
        switch3 : switch port map(
            ingresso1 => temp1,
            ingresso2 => temp3,
            selezione_input => selezione_input(0),
            selezione_output => selezione_output(0),
            uscita1 => uscita1,
            uscita2 => uscita2
        );
        
        switch4 : switch port map(
            ingresso1 => temp2,
            ingresso2 => temp4,
            selezione_input => selezione_input(0),
            selezione_output => selezione_output(0),
            uscita1 => uscita3,
            uscita2 => uscita4
        );
   

end strutturale;