library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity mux_2_1_tb is
end mux_2_1_tb;

architecture mux2_1 of mux_2_1_tb is

    component mux_2_1
        port(
            a0 : in std_logic;
            a1 : in std_logic;
            y : out std_logic;
            s : out std_logic
        );
    end component;


    signal input    :   std_logic_vector(0 to 1) := (others => 'U');
    signal control  :   std_logic := 'U';
    signal output   :   std_logic := 'U';

    begin
        utt : entity work.mux_2_1(OOO) port map(
            a0 => input(0),
            a1 => input(1),
            s => control,
            y => output
        );

        stim_proc : process
        begin

            wait for 100 ns;

            input <= "01";--control è ancora 0 però strunz
            
            wait for 10 ns;
            control <= '1';

            wait for 10 ns;
            input <= "01";

            wait for 5 ns;
            control <= '0';

            assert output = '0'
            report "errore0"
            severity failure;

            wait;
            end process;
end;