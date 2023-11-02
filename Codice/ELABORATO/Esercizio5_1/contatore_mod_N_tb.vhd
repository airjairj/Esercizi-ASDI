library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- Aggiungi questa libreria per la funzione TO_INTEGER
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_mod_n_counter is
end tb_mod_n_counter;

architecture Behavioral of tb_mod_n_counter is

  component MOD_N_COUNTER
    Generic (N : integer := 60); -- Imposta il valore di N come desideri
    Port (
      clk : in std_logic;         -- clock input
      reset : in std_logic;       -- reset input
      counter : out integer;
      outp : out std_logic
    );
  end component;

  signal reset, clk: std_logic;
  signal counter: integer; -- Modifica 16 al valore di N desiderato
  signal outp: std_logic;
begin
  dut: MOD_N_COUNTER
    generic map (N => 60)  -- Imposta il valore di N come desideri
    port map (
        clk => clk,
        reset => reset,
        counter => counter,
        outp => outp
        );

  -- Clock process definitions
  clock_process: process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Tieni lo stato di reset per 100 ns.
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait;
  end process;

end Behavioral;
