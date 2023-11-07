library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot is
    Port (
        RST_tot : in STD_LOGIC;
        CLK_tot : in STD_LOGIC;
        ore : out integer;
        minuti : out integer;
        secondi : out integer;
        h_iniziale : in integer;
        m_iniziale : in integer;
        s_iniziale : in integer
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
      outp : out std_logic;
      val_iniziale : in integer
    );
  end component;

begin
    cont_secondi: MOD_N_COUNTER
    generic map (N => 60)  -- Imposta il valore di N come desideri
    port map (
        clk => CLK_tot,
        reset => RST_tot,
        counter => secondi,
        outp => s_intermedio,
        val_iniziale => s_iniziale
        );
    cont_minuti: MOD_N_COUNTER
    generic map (N => 60)  -- Imposta il valore di N come desideri
    port map (
        clk => s_intermedio,
        reset => RST_tot,
        counter => minuti,
        outp => m_intermedio,
        val_iniziale => m_iniziale
        );

    cont_ore: MOD_N_COUNTER
    generic map (N => 24)  -- Imposta il valore di N come desideri
    port map (
        clk => m_intermedio,
        reset => RST_tot,
        counter => ore,
        outp => h_intermedio,
        val_iniziale => h_iniziale
        );


end sis_totArch;
