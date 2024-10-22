library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sis_tot_tb is
end sis_tot_tb;

architecture sis_tot_tbArch of sis_tot_tb is

    component sis_tot is
        port(
            a_tot : in STD_LOGIC_VECTOR (0 to 3);
			y_tot : out STD_LOGIC_VECTOR (0 to 3)
        );
    end component;

    signal input     : STD_LOGIC_VECTOR (0 to 3) := (others => '0');
    signal output    : STD_LOGIC_VECTOR (0 to 3) := "UUUU";

begin

    utt: sis_tot port map (
        a_tot => input,
        y_tot => output
    );

    stim_proc: process begin
        wait for 100 ns;
--                   +--- 
        input    <= "1000";
        wait for 10 ns;


        assert output = "1000"
            report "errore NON TI TROVI"
            severity failure;

        wait;
    end process;

end sis_tot_tbArch;
