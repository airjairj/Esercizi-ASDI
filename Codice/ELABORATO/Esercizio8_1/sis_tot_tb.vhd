library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity sis_tot_tb is
end entity sis_tot_tb;

architecture bench of sis_tot_tb is
  component sis_tot
    port (
      avanza_a : in STD_LOGIC;
      avanza_b : in STD_LOGIC;
      Reset : in STD_LOGIC;
      Clock : in STD_LOGIC
    );
  end component;

  signal CLK, RST: std_logic := '0';
  signal a : std_logic := '0';
  signal b : std_logic := '0';
  signal stop_the_clock: boolean := false;

  constant clock_period: time := 10 ns;

begin
  uut: sis_tot
    port map (
      Reset => RST,
      Clock => CLK,
      avanza_a => a,
      avanza_b => b
    );

  stimulus: process
  begin
    RST <= '1';
    wait for 100 ns;
    RST <= '0';
    a <= '1';
    b <= '1';
    wait for 10 ns;
    a <= '0';
    b <= '0';
    wait for 10 ns;
    a <= '1';
    wait for 10 ns;
    a <= '0';

    wait for 10000 ns;

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
