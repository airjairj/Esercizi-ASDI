library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity rico_seq_tb is
end rico_seq_tb;

architecture rico_seq_tbArch of rico_seq_tb is

    component rico_seq
        port(
            i : in std_logic;
            CLK : in std_logic;
            o : out std_logic
        );
    end component;


    signal input    :   std_logic := 'U';
    signal clock    :   std_logic := '0';
    signal output   :   std_logic := 'U';

    begin
        utt : entity work.rico_seq(rico_seqArch) port map(
            i => input,
            CLK => clock,
            o => output
        );

        stim_proc : process
        begin

            wait for 100 ns;
            input <= '0';
           
            wait for 10 ns;
            clock <= '1';

            wait for 10 ns;
            input <= '1';
            clock <= '0';

            wait for 10 ns;
            input <= '1';
            clock <= '1';

            wait for 10 ns;
            input <= '1';
            clock <= '0';

            wait for 10 ns;
            input <= '0';
            clock <= '1';

            wait for 10 ns;
            input <= '0';
            clock <= '0';

            wait for 10 ns;
            input <= '1';
            clock <= '1';

            wait for 10 ns;
            input <= '0';
            clock <= '0';

            assert output = '1'
            report "errore0"
            severity failure;

            wait;
            end process;
end;