library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot is
    Port (
        h_start : in integer;
        m_start : in integer;
        s_start : in integer;
        RST_tot : in STD_LOGIC;
        CLK_tot : in STD_LOGIC;
        ore : out integer;
        minuti : out integer;
        secondi : out integer
    );
end sis_tot;

architecture sis_totArch of sis_tot is
    signal h_intermedio : std_logic;
    signal m_intermedio : std_logic;
    signal s_intermedio : std_logic;

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


begin
    cont_secondi: MOD_N_COUNTER
    generic map (N => 60)  -- Imposta il valore di N come desideri
    port map (
        clk => CLK_tot,
        reset => RST_tot,
        counter => secondi,
        outp => s_intermedio
        );
    cont_minuti: MOD_N_COUNTER
    generic map (N => 60)  -- Imposta il valore di N come desideri
    port map (
        clk => s_intermedio,
        reset => RST_tot,
        counter => minuti,
        outp => m_intermedio
        );

    cont_ore: MOD_N_COUNTER
    generic map (N => 24)  -- Imposta il valore di N come desideri
    port map (
        clk => CLK_tot,
        reset => RST_tot,
        counter => ore,
        outp => h_intermedio
        );


end sis_totArch;
