--IMPORTANTE: FATE run 100us NELLA "Tcl Console" (in basso) PER VEDERE QUALCOSA IN SIMULAZIONE

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity sis_tot_tb is
end entity sis_tot_tb;

architecture bench of sis_tot_tb is
  component sis_tot
    port (
        start_tot : in STD_LOGIC;
        rst_tot : in STD_LOGIC;
        clk_tot : in STD_LOGIC
    );
  end component;

  signal CLK, RST: std_logic := '0';
  signal start : std_logic := '0';
  signal stop_the_clock: boolean := false;

  constant clock_period: time := 10 ns;

begin
  uut: sis_tot
    port map (
      rst_tot => RST,
      clk_tot => CLK,
      start_tot => start
    );

  stimulus: process
  begin
    RST <= '1';
    start <= '0';
    wait for 100 ns;
    RST <= '0';
    start <= '1';
    wait for 10 ns;
    start <= '0';
    wait for 20000 ns;
    start <= '1';
    wait for 10 ns;
    start <= '0';

    wait for 100000 ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= not CLK after clock_period / 2;
      wait for clock_period / 2;
    end loop;
    wait;
  end process;

end architecture bench;
