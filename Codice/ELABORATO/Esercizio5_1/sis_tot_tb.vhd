library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity sis_tot_tb is
end entity sis_tot_tb;

architecture bench of sis_tot_tb is
  component sis_tot
    port (
      RST_tot : in STD_LOGIC;
      CLK_tot : in STD_LOGIC;
      ore : out integer;
      minuti : out integer;
      secondi : out integer;
      h_iniziale : in integer;
      m_iniziale : in integer;
      s_iniziale : in integer
    );
  end component;

  signal CLK, RST: std_logic := '0';
  signal h: integer := 17;
  signal m: integer := 58;
  signal s: integer := 59;
  signal stop_the_clock: boolean := false;

  constant clock_period: time := 10 ns;

begin
  uut: sis_tot
    port map (
      RST_tot => RST,
      CLK_tot => CLK,
      h_iniziale => h,
      m_iniziale => m,
      s_iniziale => s
    );

  stimulus: process
  begin
    RST <= '1';
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
      wait for clock_period / 2;
    end loop;
    wait;
  end process;

end architecture bench;
