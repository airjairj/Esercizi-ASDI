library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot_tb is
end entity sis_tot_tb;

architecture sis_tot_tbArch of sis_tot_tb is
    component sis_tot
        port(	
                start_tot : in STD_LOGIC;
                avanza_contatore : in std_logic;
                RST_tot : in STD_LOGIC;
                CLK_tot : in STD_LOGIC;
                a_tot : in STD_LOGIC_VECTOR (0 to 3);
                y_tot : out STD_LOGIC_VECTOR (0 to 3)
            );		
    end component;

    signal start : std_logic := '0';
    signal avanza : std_logic := '0';
    signal RST   : std_logic := '1';
    signal CLK   : std_logic := '0';
    signal a     : std_logic_vector (0 to 3);
    signal y     : std_logic_vector (0 to 3);

    signal stop_the_clock: boolean := false;

    constant clock_period: time := 10 ns;

    begin
        uut : sis_tot
        port map (
            start_tot => start,
            avanza_contatore => avanza,
            RST_tot => RST,
            CLK_tot => CLK,
            a_tot => a,
            y_tot => y
        );
      
        stimulus: process
        begin
          RST <= '1';
          start <= '1';
          wait for 100 ns;
          RST <= '0';
      
          wait for 10000 ns;
      
          stop_the_clock <= true;
          wait;
        end process;
      
        clocking: process
        begin
          while not stop_the_clock loop
            CLK <= not CLK after clock_period / 2;
            avanza <= not avanza after clock_period / 4;
            wait for clock_period / 2;
          end loop;
          wait;
        end process;

end architecture sis_tot_tbArch;