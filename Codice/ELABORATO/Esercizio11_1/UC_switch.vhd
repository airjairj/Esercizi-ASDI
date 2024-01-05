library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC_switch is port(
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
end UC_switch;

architecture strutturale of UC_switch is

    signal priorita_output : std_logic_vector(1 downto 0);

    component priorita is 
    Port (
        input1 : in STD_LOGIC;
        input2 : in STD_LOGIC;
        input3 : in STD_LOGIC;
        input4 : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

begin

    prioritaUC : priorita port map(
        input1 => selezione1,
        input2 => selezione2,
        input3 => selezione3,
        input4 => selezione4,
        output => priorita_output
    );
    
    selezione_input <= priorita_output;          
    
    selezione_output <= uscita_selezione;

    with priorita_output select
        y1 	<= 	a1 when "00",	
                a2 when "01",
                a2 when "10",
                a2 when "11",
                "--" when others;
    with priorita_output select
        y2 	<= 	a1 when "00",	
                a2 when "01",
                a2 when "10",
                a2 when "11",
                "--" when others;
    with priorita_output select
        y3 	<= 	a1 when "00",	
                a2 when "01",
                a2 when "10",
                a2 when "11",
                "--" when others;
    with priorita_output select
        y4 	<= 	a1 when "00",	
                a2 when "01",
                a2 when "10",
                a2 when "11",
                "--" when others;

end strutturale;
