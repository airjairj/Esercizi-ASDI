library IEEE;
use IEEE.std_logic_1164.all;

entity switchMultistadio_tb is
end switchMultistadio_tb;

architecture behevioral of switchMultistadio_tb is

    signal a1 : std_logic_vector(1 downto 0);
    signal a2 : std_logic_vector(1 downto 0);
    signal a3 : std_logic_vector(1 downto 0);
    signal a4 : std_logic_vector(1 downto 0);
    signal y1 : std_logic_vector(1 downto 0);
    signal y2 : std_logic_vector(1 downto 0);
    signal y3 : std_logic_vector(1 downto 0);
    signal y4 : std_logic_vector(1 downto 0);
    signal selezione1 : std_logic;
    signal selezione2 : std_logic;
    signal selezione3 : std_logic;
    signal selezione4 : std_logic;
    signal uscita : std_logic_vector(1 downto 0);
    
    component switchMultistadio port(
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
    end component;
    
    
    begin
        
        uut : switchMultistadio port map(
            a1 => a1,
            a2 => a2,
            a3 => a3,
            a4 => a4,
            y1 => y1,
            y2 => y2,
            y3 => y3,
            y4 => y4,
            selezione1 => selezione1,
            selezione2 => selezione2,
            selezione3 => selezione3,
            selezione4 => selezione4,
            uscitas => uscita
        );

             process begin
                a1 <= "11";
                a2 <= "10";
                a3 <= "01";
                a4 <= "11";
                selezione1 <= '1';
                selezione2 <= '1';
                selezione3 <= '1';
                selezione4 <= '0';
                uscita <= "11";
                wait for 50 ns;
                selezione3 <= '0';
                wait for 50 ns;
                uscita <= "01";
                selezione4 <= '1';
                wait for 50 ns;
                uscita <= "00";
                selezione2 <= '0';
                wait for 50ns;
                uscita <= "10";
                selezione1 <= '0';
                wait;
            end process;

end behevioral;